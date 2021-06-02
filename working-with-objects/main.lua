function love.load()
    Object = require "classic"
    require "shape"
    require "rectangle"
    require "circle"

    r1 = Rectangle()
    r2 = Rectangle(nil,nil,nil,nil,75)
    circle = Circle()
end

function love.draw()
    r1:draw()
    r2:draw()
    circle:draw()
end

function love.update(dt)
    r1:update(dt)
    r2:update(dt)
    circle:update(dt)
end