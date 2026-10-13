-- This filter is used only by render-chapter-pdf.ps1, before Quarto's filters.
local site = 'https://reckak.github.io/statistics-for-psychology/'

function Pandoc(doc)
  local body, solutions = pandoc.List(), pandoc.List()
  local exercise, count = nil, 0
  for _, block in ipairs(doc.blocks) do
    if block.t == 'Header' and block.level == 3 then
      local label = pandoc.utils.stringify(block.content)
      local n = label:match('^(%d+)%. ')
      if n then
        assert(not exercise, 'Exercise without a solution')
        assert(tonumber(n) == count + 1, 'Exercise numbers must be consecutive')
        exercise = { number = n, title = block.content }
        block.identifier = 'pdf-exercise-' .. n
        block.classes:insert('unnumbered')
        body:insert(pandoc.RawBlock('typst', '#block(breakable: false)['))
      end
    end
    if block.t == 'Div' and block.attributes.title == 'Ukázat řešení' then
      assert(exercise, 'Solution without an exercise heading')
      count = count + 1
      solutions:insert(pandoc.Header(3, exercise.title,
        pandoc.Attr('pdf-solution-' .. exercise.number, {'unnumbered'})))
      solutions:insert(pandoc.RawBlock('typst', '#block(sticky: true)['))
      solutions:insert(pandoc.Para({pandoc.Link('Zpět na zadání', '#pdf-exercise-' .. exercise.number)}))
      solutions:insert(pandoc.RawBlock('typst', ']'))
      solutions:extend(block.content)
      body:insert(pandoc.Para({pandoc.Link('Řešení cvičení ' .. exercise.number,
        '#pdf-solution-' .. exercise.number)}))
      body:insert(pandoc.RawBlock('typst', ']'))
      exercise = nil
    else
      body:insert(block)
    end
  end
  assert(count > 0, 'No exercise solutions found')
  assert(not exercise, 'Last exercise has no solution')
  body:insert(pandoc.RawBlock('typst', '#pagebreak()'))
  body:insert(pandoc.Header(2, 'Řešení cvičení', pandoc.Attr('pdf-solutions')))
  body:extend(solutions)
  body:insert(pandoc.RawBlock('typst', '#pagebreak()'))
  body:insert(pandoc.Header(2, 'Literatura citovaná v kapitole', pandoc.Attr('pdf-references', {'unnumbered'})))
  body:insert(pandoc.Div({}, pandoc.Attr('refs')))
  doc.blocks = body
  io.stderr:write('PDF: moved ' .. count .. ' solutions.\n')
  return doc:walk({
    Para = function(para)
      if pandoc.utils.stringify(para):match('^Vstupy v ') then
        return {pandoc.RawBlock('typst', '#block(sticky: true)['), para,
          pandoc.RawBlock('typst', ']')}
      end
    end,
    Link = function(link)
      if link.target:match('^%.%./data/') then
        link.target = site .. link.target:gsub('^%.%./', '')
      elseif link.target:match('^[^/:]+%.qmd') then
        link.target = site .. 'quarto/' .. link.target:gsub('%.qmd', '.html')
      end
      return link
    end,
    Div = function(div)
      -- Long optional explanations must be able to break across PDF pages.
      if div.classes:includes('callout-note') then
        local blocks = pandoc.List()
        if div.attributes.title then
          blocks:insert(pandoc.Para({pandoc.Strong(div.attributes.title)}))
        end
        blocks:extend(div.content)
        return pandoc.Div(blocks, pandoc.Attr(div.identifier))
      end
    end
  })
end
