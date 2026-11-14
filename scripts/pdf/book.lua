-- Used only by render-book-pdf.ps1: one PDF from the introduction, the chapters,
-- literature and the three reference overviews. It runs before Quarto's own filters.
local site = 'https://reckak.github.io/statistics-for-psychology/'
-- Pages contained in the PDF and the identifier of their first heading;
-- chapters are added from the document's top-level headings in Pandoc().
local pages = {
  index = 'pdf-index', literatura = 'pdf-literatura', slovnicek = 'pdf-slovnicek',
  znaceni = 'pdf-znaceni', excel = 'pdf-excel'
}
-- Short tables in chapters 4 and 5 stay on one page, as in the chapter PDFs.
local chapterRules = {
  [4] = '#show table: it => block(breakable: false, it)',
  [5] = '#show table: it => block(breakable: false, { show raw: set text(size: 7pt); it })'
}
-- Column shares of the reference tables (the web lets them scroll).
local referenceWidths = {
  ['glossary-table'] = {0.17, 0.15, 0.25, 0.43},
  ['notation-table'] = {0.14, 0.30, 0.24, 0.20, 0.12},
  ['excel-table'] = {0.20, 0.26, 0.18, 0.27, 0.09}
}

-- Row anchors of the reference tables, written as raw Typst labels.
local rowIds = {}

local function raw(text) return pandoc.RawBlock('typst', text) end

-- Split a link target into page name and anchor; nil for external targets.
local function page_of(target)
  if target:match('^%a+:') or target:match('^#') then return nil end
  local file, anchor = target:match('^([^#]*)#?(.*)$')
  local name = file:match('([%w_]+)%.qmd$') or file:match('([%w_]+)%.html$')
  if not name then return nil end
  return name, anchor
end

-- True when a block's chapter links all lead to chapters outside this PDF.
local function only_later(block)
  local inside, outside = 0, 0
  pandoc.walk_block(block, { Link = function(link)
    local name = page_of(link.target)
    if name and name:match('^kapitola_') then
      if pages[name] then inside = inside + 1 else outside = outside + 1 end
    end
  end })
  return outside > 0 and inside == 0
end

-- Exercises and solutions of one chapter: as in chapter.lua, solutions follow all
-- exercises, but here at the end of each chapter instead of the whole document.
local function arrange_chapter(blocks, number)
  local body, solutions = pandoc.List(), pandoc.List()
  local exercise, count = nil, 0
  local key = string.format('k%02d', number)
  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 3 then
      local label = pandoc.utils.stringify(block.content)
      local n = label:match('^(%d+)%. ') or label:match('^Úloha (%d+): ')
      if n then
        assert(not exercise, 'Exercise without a solution in chapter ' .. number)
        assert(tonumber(n) == count + 1, 'Exercise numbers must be consecutive in chapter ' .. number)
        if block.identifier == '' then block.identifier = 'pdf-' .. key .. '-exercise-' .. n end
        exercise = {number = n, title = block.content, id = block.identifier}
        block.classes:insert('unnumbered')
        body:insert(raw('#block(breakable: false)['))
      end
    end
    if block.t == 'Div' and block.attributes.title == 'Ukázat řešení' then
      assert(exercise, 'Solution without an exercise heading in chapter ' .. number)
      count = count + 1
      local solution = 'pdf-' .. key .. '-solution-' .. exercise.number
      solutions:insert(pandoc.Header(3, exercise.title, pandoc.Attr(solution, {'unnumbered'})))
      solutions:insert(raw('#block(sticky: true)['))
      solutions:insert(pandoc.Para({pandoc.Link('Zpět na zadání', '#' .. exercise.id)}))
      solutions:insert(raw(']'))
      solutions:extend(block.content)
      body:insert(pandoc.Para({pandoc.Link('Řešení cvičení ' .. exercise.number, '#' .. solution)}))
      body:insert(raw(']'))
      exercise = nil
    else
      body:insert(block)
    end
  end
  assert(count > 0, 'No exercise solutions found in chapter ' .. number)
  assert(not exercise, 'Last exercise has no solution in chapter ' .. number)
  body:insert(raw('#pagebreak()'))
  body:insert(pandoc.Header(2, 'Řešení cvičení', pandoc.Attr('pdf-' .. key .. '-solutions')))
  body:extend(solutions)
  io.stderr:write('PDF: chapter ' .. number .. ': moved ' .. count .. ' solutions.\n')
  return body
end

-- A reference table written as raw HTML becomes a native Pandoc table.
local function reference_table(html)
  local id = html:match('<table id="([^"]+)"')
  -- Same-page anchors name their page, so a target in an omitted row goes to the web.
  local page = ({['glossary-table'] = 'slovnicek', ['notation-table'] = 'znaceni',
    ['excel-table'] = 'excel'})[id]
  assert(page, 'Unknown reference table: ' .. tostring(id))
  html = html:gsub('href="#', 'href="' .. page .. '.html#')
  -- Inline TeX and *emphasis* are Markdown in the web source; mark them as HTML.
  html = html:gsub('%$([^$<]+)%$', '<span class="math inline">%1</span>')
  html = html:gsub('%*([^%s*<][^*<]-)%*', '<em>%1</em>')
  local table = pandoc.read(html, 'html').blocks[1]
  assert(table and table.t == 'Table', 'Reference table not recognised: ' .. tostring(id))
  local dropped = 0
  for _, body in ipairs(table.bodies) do
    local kept = pandoc.List()
    for _, row in ipairs(body.body) do
      -- Rows explained only in chapters outside this PDF are left out.
      if only_later(pandoc.Div(row.cells:map(function(c) return pandoc.Div(c.contents) end))) then
        dropped = dropped + 1
      else
        if row.identifier ~= '' then
          rowIds[row.identifier] = true
          -- Anchor without a following space, so the cell text keeps its alignment.
          row.cells[1].contents[1].content:insert(1,
            pandoc.RawInline('typst', '#box(width: 0pt)[]<' .. row.identifier .. '>'))
        end
        kept:insert(row)
      end
    end
    body.body = kept
  end
  local widths = referenceWidths[id]
  if widths then
    for i, spec in ipairs(table.colspecs) do table.colspecs[i] = {spec[1], widths[i]} end
  end
  io.stderr:write('PDF: ' .. id .. ': omitted ' .. dropped .. ' rows for chapters outside the PDF.\n')
  return table:walk({
    Span = function(span)
      if span.classes:includes('math') then
        return pandoc.Math('InlineMath', pandoc.utils.stringify(span.content))
      end
    end })
end

function Pandoc(doc)
  -- Split the combined document at its top-level headings.
  local parts, current = {}, nil
  for _, block in ipairs(doc.blocks) do
    if block.t == 'Header' and block.level == 1 then
      current = {header = block, blocks = pandoc.List()}
      table.insert(parts, current)
    elseif current then
      current.blocks:insert(block)
    else
      error('Content before the first top-level heading')
    end
  end
  for _, part in ipairs(parts) do
    local n = part.header.identifier:match('^sec%-kapitola%-(%d+)$')
    if n then pages['kapitola_' .. n] = part.header.identifier end
  end
  local result = pandoc.List()
  for _, part in ipairs(parts) do
    local number = tonumber(part.header.identifier:match('^sec%-kapitola%-(%d+)$'))
    local blocks = part.blocks
    if number then
      -- Chapter scope: heading and figure numbers and the chapter's own table rules.
      result:insert(raw(table.concat({
        '#counter(heading).update(' .. (number - 1) .. ')',
        '#counter(figure.where(kind: "quarto-float-fig")).update(0)',
        '#counter(figure.where(kind: "quarto-float-tbl")).update(0)',
        '#[',
        '#set figure(numbering: n => "' .. number .. '." + str(n))',
        chapterRules[number] or ''
      }, '\n')))
      blocks = arrange_chapter(blocks, number)
    else
      result:insert(raw('#['))
      -- Overview paragraphs that only point to chapters outside the PDF are left out;
      -- chapter text keeps its references to later chapters.
      blocks = blocks:filter(function(block) return not (block.t == 'Para' and only_later(block)) end)
    end
    result:insert(part.header)
    result:extend(blocks)
    result:insert(raw(']'))
  end
  doc.blocks = result

  doc = doc:walk({
    RawBlock = function(block)
      if block.format == 'html' and block.text:match('<table') then
        return reference_table(block.text)
      end
    end,
    Para = function(para)
      local text = pandoc.utils.stringify(para)
      if text:match('^Vstupy v ') then
        return {raw('#block(sticky: true)['), para, raw(']')}
      end
    end,
    Div = function(div)
      -- Long optional explanations must be able to break across PDF pages.
      if div.classes:includes('callout-note') then
        local blocks = pandoc.List()
        if div.attributes.title then
          local parsed = pandoc.read(div.attributes.title, 'markdown').blocks
          local title = #parsed > 0 and parsed[1].content or {pandoc.Str(div.attributes.title)}
          blocks:insert(pandoc.Para({pandoc.Strong(title)}))
        end
        blocks:extend(div.content)
        return pandoc.Div(blocks, pandoc.Attr(div.identifier))
      end
    end
  })

  -- Every identifier present in the PDF; links elsewhere go to the public web.
  local ids = {}
  local function note(el) if el.identifier and el.identifier ~= '' then ids[el.identifier] = true end end
  doc:walk({Block = note, Inline = note})
  for id in pairs(rowIds) do ids[id] = true end
  for _, part in ipairs(parts) do ids[part.header.identifier] = true end
  local function web(name, anchor)
    local path = name == 'index' and 'index.html' or 'quarto/' .. name .. '.html'
    return site .. path .. (anchor ~= '' and '#' .. anchor or '')
  end
  return doc:walk({
    Link = function(link)
      local target = link.target
      if target:match('^%.%./data/') or target:match('^data/') then
        link.target = site .. target:gsub('^%.%./', '')
        return link
      end
      local name, anchor = page_of(target)
      if not name then return nil end
      if pages[name] and anchor == '' then
        link.target = '#' .. pages[name]
      elseif pages[name] and ids[anchor] then
        link.target = '#' .. anchor
      else
        link.target = web(name, anchor)
      end
      return link
    end
  })
end
