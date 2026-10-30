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
      if el.classes:includes('table-note') then
        el.content:insert(1, pandoc.RawBlock('typst', '#block[\n#set text(size: 1em - 1pt)'))
        el.content:insert(pandoc.RawBlock('typst', ']'))
        return el
      end
    end },
  { Span = function(el)
      -- Empty source anchors following a heading must not label that heading twice.
      if el.identifier ~= '' and #el.content == 0 then
        return pandoc.RawInline('typst', '#box(width: 0pt)[] <' .. el.identifier .. '>')
      end
    end },
  { Math = function(el)
      -- Text produces an atomic upright number in Typst, including in subscripts.
      el.text = el.text:gsub('(%d+{,}%d+)', function(number)
        return '\\text{' .. number:gsub('{,}', ',') .. '}'
      end)
      return el
    end },
  { Inlines = bind }
}
