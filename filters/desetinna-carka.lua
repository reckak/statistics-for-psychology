-- Czech decimal comma in HTML MathML.
-- Sources write decimal numbers as 0{,}841. Pandoc would otherwise emit
-- <mn>0</mn><mo>,</mo><mn>841</mn> and browsers add separator spacing.
-- Only commas written as {,} between digits are treated as decimal commas;
-- plain commas such as N(50,10) keep their meaning. PDF output is untouched.

if not quarto.doc.is_format('html') then
  return {}
end

local writer_options = pandoc.WriterOptions({ html_math_method = 'mathml' })

local function escape_html(text)
  return (text:gsub('&', '&amp;'):gsub('<', '&lt;'):gsub('>', '&gt;'))
end

local function to_mathml(el)
  local tex = el.text
  if not tex:find('%d{,}%d') then
    return nil
  end
  -- A literal decimal point would be indistinguishable after conversion.
  if tex:find('%d%.%d') then
    quarto.log.warning('desetinna-carka: výraz už obsahuje desetinnou tečku, ponechán beze změny: ' .. tex)
    return nil
  end
  local dotted = tex:gsub('(%d){,}(%d)', '%1.%2')
  local doc = pandoc.Pandoc({ pandoc.Plain({ pandoc.Math(el.mathtype, dotted) }) })
  local html = pandoc.write(doc, 'html', writer_options)
  if not html:find('<math') then
    quarto.log.warning('desetinna-carka: převod na MathML se nezdařil: ' .. tex)
    return nil
  end
  -- Restore the decimal comma inside numeric literals only.
  html = html:gsub('<mn>([^<]*)</mn>', function(number)
    return '<mn>' .. number:gsub('%.', ',') .. '</mn>'
  end)
  -- Keep the original TeX source in the annotation.
  html = html:gsub('(<annotation encoding="application/x%-tex">).-(</annotation>)', function(open, close)
    return open .. escape_html(tex) .. close
  end)
  html = html:gsub('^%s+', ''):gsub('%s+$', '')
  return pandoc.RawInline('html', html)
end

return {
  { Math = to_mathml }
}
