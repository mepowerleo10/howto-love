function love.load()
    r1 = {
        x = 10,
        y = 100,
        width = 100,
        height = 100,
    }

    r2 = {
        x = 250,
        y = 120,
        width = 150,
        height = 120
    }
end

function love.draw()
    local mode
    if isColliding(r1, r2) then
        mode = "fill"
    else
        mode = "line"
    end

    love.graphics.rectangle(mode, r1.x, r1.y, r1.width, r1.height)
    love.graphics.rectangle(mode, r2.x, r2.y, r2.width, r2.height)
end

function love.update(dt)
    speed = 100
    if love.keyboard.isDown("right") then
        r1.x = r1.x + speed * dt
    elseif love.keyboard.isDown("left") then
        r1.x = r1.x - speed * dt
    elseif love.keyboard.isDown("up") then
        r1.y = r1.y - speed * dt
    elseif love.keyboard.isDown("down") then
        r1.y = r1.y + speed * dt
    end
end

function love.keypressed(key)
    
end

function isColliding(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    -- perform the bounds check to verify collision
    if  a_right > b_left and
        a_left < b_right and
        a_bottom > b_top and
        a_top < b_bottom then
        -- there is a collision
        return true
    else
        return false
    end
end