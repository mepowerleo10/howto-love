require("bricks")

local ball = require("ball")
local platform = require("platform")
local bricks = require("bricks")

function love.load()
  bricks.add_to_current_level_bricks(bricks.new_brick(100, 100))
  bricks.add_to_current_level_bricks(bricks.new_brick(160,100))
end

function love.draw()
  ball.draw()
  platform.draw()
  bricks.draw()
end

function love.update(dt)
  ball.update(dt)
  platform.update(dt)
  bricks.update(dt)
end

function love.quit()
  love.graphics.print("Bye... 👋")
end