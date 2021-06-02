function love.load()
    --[[ tick = require "../tick"

    drawRectangle = false
    tick.delay(function() drawRectangle = true end, 2) ]]
    x = 30
    y = 50

    tick = require "../tick"
end

function love.update(dt)
    -- tick.update(dt)
end

function love.draw()
   --[[  if drawRectangle then
        love.graphics.rectangle("fill", 100, 100, 300, 200)
    end ]]
    love.graphics.rectangle("line", x, y, 100, 50)
end

function love.keypressed(key)
    if key == "space" then
        x = math.random(100, 500)
        y = math.random(100, 500)
    end
end