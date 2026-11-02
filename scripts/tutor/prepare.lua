-- Parse the authored HTML overviews before citation processing. Never filter rows.
local function overview(html)
  html = html:gsub('%$(.-)%$', function(tex)
    return '<span class="math inline">' .. tex:gsub('<', '&lt;'):gsub('>', '&gt;') .. '</span>'
  end)
  html = html:gsub('%*([^%s*<][^*<]-)%*', '<em>%1</em>')
  local parsed = pandoc.read(html, 'html'):walk({
    Span = function(span)
      if span.classes:includes('math') then
        return pandoc.Math('InlineMath', pandoc.utils.stringify(span.content))
      end
    end
  })
  local tab = parsed.blocks[1]
  assert(tab and tab.t == 'Table', 'The overview must parse as one table')
  local labels = {}
  for _, cell in ipairs(tab.head.rows[1].cells) do
    labels[#labels + 1] = pandoc.utils.stringify(cell.contents)
  end
  local blocks = pandoc.List()
  for _, body in ipairs(tab.bodies) do
    for _, row in ipairs(body.body) do
      assert(row.identifier ~= '', 'Overview row without a stable identifier')
      local title = pandoc.utils.stringify(row.cells[1].contents)
      blocks:insert(pandoc.Header(2, title, pandoc.Attr(row.identifier)))
      for i, cell in ipairs(row.cells) do
        blocks:insert(pandoc.Para({pandoc.Strong(labels[i] .. ':')}))
        blocks:extend(cell.contents)
      end
    end
  end
  return pandoc.Div(blocks, pandoc.Attr(tab.identifier))
end

function RawBlock(block)
  if block.format == 'html' and block.text:match('^<table ') then
    return overview(block.text)
  end
end

function Div(div)
  -- Titles and optional/solution labels must be visible in plain Markdown too.
  local title = div.attributes.title
  if title then
    local text = pandoc.read(title, 'markdown-smart').blocks[1]
    div.content:insert(1, pandoc.Para({pandoc.Strong(text.content)}))
    div.attributes.title = nil
  end
  div.attributes.collapse = nil
  div.attributes.role = nil
  div.attributes['aria-label'] = nil
  div.attributes.tabindex = nil
  return div
end
