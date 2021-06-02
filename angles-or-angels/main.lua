function love.load()
    circle = {}
    circle.x = 100
    circle.y = 100
    circle.radius = 25
    circle.speed = 200
end

function love.draw()
    love.graphics.circle("line", circle.x, circle.y, circle.radius)
    -- love.graphics.print("angle: " .. angle, 10, 10)

    love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
    love.graphics.line(mouse_x, mouse_y, mouse_x, circle.y)
    love.graphics.line(circle.x, circle.y, mouse_x, circle.y)

    love.graphics.print("distance: " .. distance, 10, 10)
    love.graphics.circle("line", circle.x, circle.y, distance)
end

function love.update(dt)
    mouse_x, mouse_y = love.mouse.getPosition()
    angle = math.atan2(mouse_y - circle.y, mouse_x - circle.x)

    cos = math.cos(angle)
    sin = math.sin(angle)

    -- move only when near by 400px
    distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)
    if distance < 400 then
        circle.x = circle.x + circle.speed * distance/100 * cos * dt
        circle.y = circle.y + circle.speed * distance/100 * sin * dt
    end
end

function getDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt((dx^2) + (dy^2))
end