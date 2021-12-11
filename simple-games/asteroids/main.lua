function reset()
    arenaWidth = 800
    arenaHeight = 600

    shipX = arenaWidth / 2
    shipY = arenaHeight / 2
    shipAngle = 0
    shipRadius = 30
    shipSpeedX = 0
    shipSpeedY = 0
    mode = 'fill'

    bullets = {}
    bulletRadius = 5
    bulletTimerLimit = 0.25
    bulletTimer = bulletTimerLimit

    asteroids = {
        {
            x = 100,
            y = 100,
        },
        {
            x = arenaWidth - 100,
            y = 100,
        },
        {
            x = arenaWidth / 2,
            y = arenaHeight - 100
        }
    }

    -- each asteroid moves in a random angle
    for asteroidIdx, asteroid in ipairs(asteroids) do
        asteroid.angle = love.math.random() * (2 * math.pi)
        asteroid.stage = #asteroidStages
    end
end

function love.load()
    delta = 0

    asteroidStages = {
        {
            speed = 120,
            radius = 15,
        },
        {
            speed = 70,
            radius = 30
        },
        {
            speed = 50,
            radius = 50,
        },
        {
            speed = 20,
            radius = 80
        }
    }

    reset()
end

function love.draw()
    for y = -1, 1 do
        for x = -1, 1 do
            love.graphics.origin()
            -- Drawing partially off-screen objects
            love.graphics.translate(x * arenaWidth, y * arenaHeight)

            love.graphics.setColor(0, 0, 1)
            love.graphics.circle(mode, shipX, shipY, shipRadius)

            local shipCircleDistance = 20
            love.graphics.setColor(0, 1, 1)
            love.graphics.circle(
                mode,
                shipX + math.cos(shipAngle) * shipCircleDistance,
                shipY + math.sin(shipAngle) * shipCircleDistance,
                5
            )

            for bulletIdx, bullet in ipairs(bullets) do
                love.graphics.setColor(0, 1, 0)
                love.graphics.circle('fill', bullet.x, bullet.y, bulletRadius)
            end

            for asteroidIdx, asteroid in ipairs(asteroids) do
                love.graphics.setColor(1, 1, 0)
                love.graphics.circle('fill', asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius)
            end
        end
    end

    -- Temporary
    love.graphics.origin()
    -- Debugging information
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(table.concat({
        'shipAngle: ' .. shipAngle,
        'shipX: ' .. shipX,
        'shipY: ' .. shipY,
        'shipSpeedX: ' .. shipSpeedX,
        'shipSpeedY: ' .. shipSpeedY,
        'dt: ' .. delta,
    }, '\n'))

end

function areCirclesIntersecting(aX, aY, aRadius, bX, bY, bRadius)
    return (aX - bX)^2 + (aY - bY)^2 <= (aRadius + bRadius)^2
end

function love.update(dt)
    delta = dt

    -- Rotate the ship left or right
    local turnSpeed = 10
    if love.keyboard.isDown('right') then
        shipAngle = shipAngle + turnSpeed * dt
    elseif love.keyboard.isDown('left') then
        shipAngle = shipAngle - turnSpeed * dt
    end
    shipAngle = shipAngle % (2 * math.pi)

    -- Move the ship forward
    local shipSpeed = 100
    if love.keyboard.isDown('up') then
        shipSpeedX = shipSpeedX + math.cos(shipAngle) * shipSpeed * dt
        shipSpeedY = shipSpeedY + math.sin(shipAngle) * shipSpeed * dt
    end
    shipX = (shipX + shipSpeedX * dt) % arenaWidth
    shipY = (shipY + shipSpeedY * dt) % arenaHeight

    for bulletIdx, bullet in ipairs(bullets) do
        bullet.timeLeft = bullet.timeLeft - dt
        if bullet.timeLeft <= 0 then
            table.remove(bullets, bulletIdx)
        else
            local bulletSpeed = 500
            bullet.x = (bullet.x + math.cos(bullet.angle) * bulletSpeed * dt) % arenaWidth
            bullet.y = (bullet.y + math.sin(bullet.angle) * bulletSpeed * dt) % arenaHeight
        end

        for asteroidIdx, asteroid in ipairs(asteroids) do
            if areCirclesIntersecting(
                bullet.x, bullet.y, bulletRadius,
                asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius
            ) then -- break the asteroid and create new pieces
                table.remove(bullets, bulletIdx)

                if asteroid.stage > 1 then
                    local angle1 = love.math.random() * (2 * math.pi)
                    local angle2 = (angle1 - math.pi) % (2 * math.pi)

                    table.insert(asteroids, {
                        x = asteroid.x,
                        y = asteroid.y,
                        angle = angle1,
                        stage = asteroid.stage - 1,
                    })
                    table.insert(asteroids, {
                        x = asteroid.x,
                        y = asteroid.y,
                        angle = angle2,
                        stage = asteroid.stage - 1,
                    })
                end
                table.remove(asteroids, asteroidIdx)
                break
            end
        end
        
    end

    -- Holding space fires
    bulletTimer = bulletTimer + dt
    if love.keyboard.isDown("space") then
        if bulletTimer >= bulletTimerLimit then
            bulletTimer = 0
            table.insert(bullets, {
                x = shipX + math.cos(shipAngle) * shipRadius,
                y = shipY + math.sin(shipAngle) * shipRadius,
                angle = shipAngle,
                timeLeft = 4,
            })
        end
    end

    -- moving the asteroids within the frame
    for asteroidIdx, asteroid in ipairs(asteroids) do
        asteroid.x = (asteroid.x + math.cos(asteroid.angle) * asteroidStages[asteroid.stage].speed * dt) % arenaWidth
        asteroid.y = (asteroid.y + math.sin(asteroid.angle) * asteroidStages[asteroid.stage].speed * dt) % arenaHeight

        if areCirclesIntersecting(
            shipX, shipY, shipRadius,
            asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius
        ) then
            reset()
            break
        end
    end

    if #asteroids == 0 then
        reset()
    end
end