-- PDF-only typography. Keep the source TeX, HTML filter and mathematical commas intact.
local singles = {a=true,i=true,k=true,o=true,s=true,u=true,v=true,z=true,
  A=true,I=true,K=true,O=true,S=true,U=true,V=true,Z=true}

local function last_word(el)
  if el.t == 'Str' then return el.text:match('([%a\128-\255]+)$') end
  if el.t == 'Emph' or el.t == 'Strong' or el.t == 'Span' or el.t == 'Link' then
    if #el.content > 0 then return last_word(el.content[#el.content]) end
  end
end

local function bind(inlines)
  for i=2,#inlines-1 do
    if (inlines[i].t == 'Space' or inlines[i].t == 'SoftBreak') and
        singles[last_word(inlines[i-1]) or ''] then
      inlines[i] = pandoc.Str('\u{00A0}')
    end
  end
  return inlines
end

return {
  { Div = function(el)
      local changed = false
      local title = el.attributes.title
      if title then
        -- Quarto parses callout titles as Markdown; ASCII quotes become a
        -- quotation that Typst sets with Czech quotes (the Str pass cannot see it).
        local new = title:gsub('\u{201E}', '"'):gsub('\u{201C}', '"')
          :gsub('\u{201A}', "'"):gsub('\u{2018}', "'")
        if new ~= title then el.attributes.title = new; changed = true end
      end
      if el.classes:includes('table-note') then
        el.content:insert(1, pandoc.RawBlock('typst', '#block[\n#set text(size: 9pt)'))
        el.content:insert(pandoc.RawBlock('typst', ']'))
        return el
      end
      if changed then return el end
    end },
  { Span = function(el)
      -- Empty source anchors following a heading must not label that heading twice.
      if el.identifier ~= '' and #el.content == 0 then
        return pandoc.RawInline('typst', '#box(width: 0pt)[] <' .. el.identifier .. '>')
      end
    end },
  { Math = function(el)
      -- Text produces an atomic upright number in Typst, including in subscripts.
      -- Typst spaces "- upright(..)" as a binary minus, so a unary minus (at the
      -- start or after a relation, bracket, separator or command) joins the number.
      local function upright(prefix, number, stop)
        return '\\text{' .. prefix .. number:gsub('{,}', ',') .. stop .. '}'
      end
      local text = el.text
      text = text:gsub('()%-%s*(%d+{,}%d+)', function(pos, number)
        local before = text:sub(1, pos - 1):gsub('%s+$', '')
        if before == '' or before:match('[=<>%(%[{,;:]$') or before:match('\\%a+$') then
          return upright('\u{2212}', number, '')
        end
      end)
      -- A final full stop directly after a number otherwise stands apart from it.
      text = text:gsub('(%d+{,}%d+)%.%s*$', function(number) return upright('', number, '.') end)
      el.text = text:gsub('(%d+{,}%d+)', function(number) return upright('', number, '') end)
      return el
    end },
  { Inlines = bind },
  { Str = function(el)
      -- Pandoc 3.10 writes a literal “ or ‘ as a Typst smart quote, which then
      -- opens a new quotation („). Typst escapes keep the Czech quotes as typed.
      -- Lua patterns are byte-based, so search the three-byte sequences literally.
      local quotes = {'\u{201E}', '\u{201C}', '\u{201A}', '\u{2018}'}
      local out = pandoc.List()
      local rest = el.text
      while rest ~= '' do
        local best
        for _, q in ipairs(quotes) do
          local p = rest:find(q, 1, true)
          if p and (not best or p < best[1]) then best = {p, q} end
        end
        if not best then out:insert(pandoc.Str(rest)); break end
        if best[1] > 1 then out:insert(pandoc.Str(rest:sub(1, best[1] - 1))) end
        out:insert(pandoc.RawInline('typst', string.format('\\u{%X}', utf8.codepoint(best[2]))))
        rest = rest:sub(best[1] + #best[2])
      end
      return out
    end }
}
