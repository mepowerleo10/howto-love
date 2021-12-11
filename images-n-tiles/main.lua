require 'map-functions'

function love.load()
  loadMap('maps/core-dump.lua')
end

function love.draw()
  drawMap(TileTable, TileSet, TileW, TileH)
end

