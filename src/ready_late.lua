local layout = ScreenData.MetaUpgradeCardLayout
local data = layout.ComponentData
local order = data.Order

local ROWS_PER_COLUMN = 8 
local FIRST_NEW = 17 

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

MetaUpgradeSaveLayoutData.MaximumMetaUpgradeLayouts = config.totalLayouts

for i = FIRST_NEW, config.totalLayouts do
  local name = "LayoutSet" .. i
  local column = math.floor((i - 1) / ROWS_PER_COLUMN)
  local row = (i - 1) % ROWS_PER_COLUMN
  local base = data["LayoutSet" .. (row + 1)]

  data[name] = MergeTables(layout.LayoutSetTemplate, {
    MetaUpgradeLayoutNum = i,
    X = base.X + column * config.columnOffsetX,
    Y = base.Y,
  })
  insertBefore(order, "LayoutSetSelectionHighlight", name)
end