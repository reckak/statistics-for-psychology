-- Shared table styling for the web book and the manual PDFs (R54, R78).
-- 1. Mark semantic totals; never infer totals from position.
-- 2. Wrap long Excel formulas in table cells for readability (R78). The source keeps the formula
--    on one line; only the rendered cell breaks it after an argument separator and indents the
--    continuation under the opening parenthesis of the argument list it continues.

local WRAP_FROM, LINE_WIDTH, SHORT_TAIL = 50, 40, 6  -- a short final piece such as "/2" never starts a line
local NBSP = '\u{00A0}'

local function chars(text)
  local out = {}
  for _, cp in utf8.codes(text) do out[#out + 1] = utf8.char(cp) end
  return out
end

-- Split a formula into segments that end at a break candidate no deeper than max_depth
-- (depth = number of open parentheses): after ';' outside quotes, or before a binary or
-- comparison operator (formulas such as Welch df have no argument separators at the top level).
local function segments(cs, max_depth)
  local segs, cur, depth, quoted = {}, {}, 0, false
  for i, c in ipairs(cs) do
    if not quoted and depth <= max_depth and i > 2 and c:match('^[/%*%+%-<>=]$')
        and cs[i - 1]:match('^[%)%w]$') and #cur > 0 then
      segs[#segs + 1] = cur; cur = {}
    end
    cur[#cur + 1] = c
    if c == '"' then quoted = not quoted
    elseif not quoted and c == '(' then depth = depth + 1
    elseif not quoted and c == ')' then depth = depth - 1
    elseif not quoted and c == ';' and depth <= max_depth then segs[#segs + 1] = cur; cur = {} end
  end
  if #cur > 0 then segs[#segs + 1] = cur end
  return segs
end

-- Greedy layout: start a new line when the next segment would exceed LINE_WIDTH; indent the
-- new line to the column just after the innermost open parenthesis at the break. If that
-- alignment would push the line past LINE_WIDTH (a long function name such as
-- SOUČIN.SKALÁRNÍ), use a hanging indent of two characters from the start of the function name.
local function layout(segs)
  local lines, widths, line, col, stack, quoted, name_start = {}, {}, {}, 0, {}, false, 0
  for k, seg in ipairs(segs) do
    local short_tail = k == #segs and #seg <= SHORT_TAIL
    if #line > 0 and not short_tail and col + #seg > LINE_WIDTH then
      lines[#lines + 1] = table.concat(line); widths[#widths + 1] = col
      local open = stack[#stack]
      local indent = open and open.col or 1
      if open and indent + #seg > LINE_WIDTH then indent = math.min(indent, open.name + 2) end
      line = {string.rep(NBSP, indent)}; col = indent; name_start = col
    end
    for _, c in ipairs(seg) do
      line[#line + 1] = c; col = col + 1
      if c == '"' then quoted = not quoted end
      if not quoted and c == '(' then stack[#stack + 1] = {col = col, name = name_start}
      elseif not quoted and c == ')' then stack[#stack] = nil end
      -- Function names consist of letters, digits, dots and underscores.
      if quoted or not c:match('^[%w%._]$') and c:byte() < 128 then name_start = col end
    end
  end
  lines[#lines + 1] = table.concat(line); widths[#widths + 1] = col
  return lines, math.max(table.unpack(widths))
end

-- Prefer breaks at the shallowest nesting level; go deeper only while lines stay too long.
local function wrap_formula(text)
  if utf8.len(text) <= WRAP_FROM then return nil end
  local cs, best, best_width = chars(text), nil, math.huge
  for depth = 0, 6 do
    local lines, width = layout(segments(cs, depth))
    if width < best_width then best, best_width = lines, width end
    if width <= LINE_WIDTH + 5 then break end
  end
  local lines = best
  if #lines < 2 then return nil end
  local inlines = {}
  for i, l in ipairs(lines) do
    if i > 1 then inlines[#inlines + 1] = pandoc.LineBreak() end
    inlines[#inlines + 1] = pandoc.Code(l)
  end
  return inlines
end

local wrap_cell = {
  Code = function(code)
    if code.text:sub(1, 1) ~= '=' then return nil end
    return wrap_formula(code.text)
  end
}

function Table(tbl)
  local numeric, seen = {}, {}
  for i = 1, #tbl.colspecs do numeric[i] = true end
  for _, body in ipairs(tbl.bodies) do
    for _, row in ipairs(body.body) do
      local first = pandoc.utils.stringify(row.cells[1].contents)
      if first:match('^Součet') or first:match('^Celkem') then
        for _, cell in ipairs(row.cells) do cell.classes:insert('table-summary') end
      else
        for i, cell in ipairs(row.cells) do
          local text = pandoc.utils.stringify(cell.contents)
          if text ~= '' then
            seen[i] = true
            local value = text:gsub('−', '-'):gsub('[%s%%]', ''):gsub('\u{00A0}', ''):gsub(',', '.')
            if not tonumber(value) then numeric[i] = false end
          end
        end
      end
    end
  end
  for i, spec in ipairs(tbl.colspecs) do
    if spec[1] == 'AlignDefault' and numeric[i] and seen[i] then
      tbl.colspecs[i] = {pandoc.AlignRight, spec[2]}
    end
  end
  -- A long source line makes Pandoc give every pipe-table column an equal share, which squeezes
  -- the formula column. Tables with Excel formulas therefore keep automatic column widths.
  local has_formula = false
  local find_formula = {Code = function(code) if code.text:sub(1, 1) == '=' then has_formula = true end end}
  for _, body in ipairs(tbl.bodies) do
    for _, row in ipairs(body.body) do
      for _, cell in ipairs(row.cells) do pandoc.Blocks(cell.contents):walk(find_formula) end
    end
  end
  if has_formula then
    for i, spec in ipairs(tbl.colspecs) do tbl.colspecs[i] = {spec[1], pandoc.ColWidthDefault} end
  end
  return tbl:walk(wrap_cell)
end
