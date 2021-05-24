function love.load()
    x = 100
end

function love.update(dt)
    word = dt

    if love.keyboard.isDown("right") then
        x = x + 50 * dt
    elseif love.keyboard.isDown("left") then
        x = x - 50 * dt
    end
end

function love.draw()
    love.graphics.rectangle("line", x, 50, 200, 150)
    love.graphics.print(word, 100, 100)
end