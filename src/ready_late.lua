  local layout = ScreenData.MetaUpgradeCardLayout
  local data = layout.ComponentData
  local order = data.Order

  local ROWS_PER_COLUMN = 8
  local total = config.totalLayouts
  local scale = config.layoutScale or 0.75
  local spacing = config.columnSpacing or 71
  local columns = math.ceil(total / ROWS_PER_COLUMN)

  -- Diagnóstico (se puede borrar cuando funcione)
  for k, v in pairs(layout.LayoutSetTemplate) do
    print("[Arcana30] template." .. tostring(k) .. " = " .. tostring(v))
  end
  for k, v in pairs(data.LayoutSet1) do
    print("[Arcana30] LayoutSet1." .. tostring(k) .. " = " .. tostring(v))
  end

  local function insertBefore(tbl, before, value)
    for _, v in ipairs(tbl) do
      if v == value then return end
    end
    for k, v in ipairs(tbl) do
      if v == before then
        table.insert(tbl, k, value)
        return
      end
    end
    table.insert(tbl, value)
  end

  local rightX = data.LayoutSet9.X
  local rowY = {}
  for r = 1, ROWS_PER_COLUMN do
    rowY[r] = data["LayoutSet" .. r].Y
  end

  MetaUpgradeSaveLayoutData.MaximumMetaUpgradeLayouts = total

  for i = 1, total do
    local name = "LayoutSet" .. i
    local column = math.floor((i - 1) / ROWS_PER_COLUMN)
    local row = (i - 1) % ROWS_PER_COLUMN

    if data[name] == nil then
      data[name] = MergeTables(layout.LayoutSetTemplate, { MetaUpgradeLayoutNum = i })
    end

    data[name].X = rightX - (columns - 1 - column) * spacing
    data[name].Y = rowY[row + 1]
    data[name].Scale = scale

    insertBefore(order, "LayoutSetSelectionHighlight", name)
    print(string.format("[Arcana30] %s -> X=%s Y=%s", name, tostring(data[name].X), tostring(data[name].Y)))
  end 