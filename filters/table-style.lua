-- Mark semantic totals for shared table styling; never infer totals from position.
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
  return tbl
end
