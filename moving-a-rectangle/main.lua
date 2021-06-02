function love.load()
    rect = {}
    rect.width = 70
    rect.height = 90
    rect.x = 100
    rect.y = 100
    rect.speed = 100
end

function love.update(dt)
    delta = dt

    if love.keyboard.isDown("right") then
        rect.x = rect.x + rect.speed * dt
    elseif love.keyboard.isDown("left") then
        rect.x = rect.x - rect.speed * dt
    elseif love.keyboard.isDown("up") then
        rect.y = rect.y - rect.speed * dt
    elseif love.keyboard.isDown("down") then
        rect.y = rect.y + rect.speed * dt
    end
end

function love.draw()
    love.graphics.rectangle("line", rect.x, rect.y, rect.width, rect.height)
    love.graphics.print("delta: "..delta, 100, 100)
end