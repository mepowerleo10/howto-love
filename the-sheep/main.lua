function love.load()
    Object = require "classic"
    require "sheep"

    sheep = Sheep()
end

function love.draw()
    sheep:draw()
end

function love.update(dt)
    sheep:update(dt)
end