-- Returns a map tileset from a tile string
function newMap(tileW, tileH, tileSetPath, quadInfo, tileString)
  TileSet = love.graphics.newImage(tileSetPath)
  TileW, TileH = tileW, tileH

  local tilesetW, tilesetH = TileSet:getWidth(), TileSet:getHeight()

  Quads = {}

  for _, info in ipairs(quadInfo) do
    -- info[1] == character, info[2] == x, info[3] == y
    Quads[info[1]] = love.graphics.newQuad(
        info[2], info[3], tileW, tileH, tilesetW, tilesetH)
  end

  TileTable = genTileTable(tileString)
end

-- Loads the map from the filesystem
function loadMap(path)
    love.filesystem.load(path)()
end

-- Generates the map tile table from a tile string
function genTileTable(tileString)
  local tileTable = {}
  local width = #(tileString:match("[^\n]+"))
  for x=1,width,1 do tileTable[x] = {} end

  local ri, ci = 1, 1
  for row in tileString:gmatch("[^\n]+") do
    assert(#row == width, 'Map is not aligned: width of row '
      .. tostring(ri) .. ' should be '
      .. tostring(width) .. ', but it is ' .. tostring(#row))
      ci = 1
    for character in row:gmatch(".") do
      tileTable[ci][ri] = character
      ci = ci + 1
    end
      ri = ri + 1
  end

  return tileTable
end

--- Draw the map from the tile table
function drawMap(tileTable, tileSet, tileW, tileH)
  for colIdx, col in ipairs(tileTable) do
    for rowIdx, row in ipairs(col) do
      local x, y = (colIdx - 1) * tileW, (rowIdx - 1) * tileH
      love.graphics.draw(tileSet, Quads[row], x, y)
    end
  end
end

