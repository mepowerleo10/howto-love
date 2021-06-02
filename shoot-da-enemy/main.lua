function love.load()
    Object = require "classic"
    require "player"
    require "enemy"
    require "bullet"
    require "counter"

    player = Player()
    enemy = Enemy()
    firedBullets = {}
    counter = Counter()
end

function love.draw()
    player:draw()
    enemy:draw()
    counter:draw()

    -- draw the individual bullets
    for i,v in ipairs(firedBullets) do
        v:draw()
    end
end

function love.update(dt)
    player:update(dt)
    enemy:update(dt)
    counter:update(dt)

    -- update the bullet positions
    for i,v in ipairs(firedBullets) do
        v:update(dt)
        v:checkCollision(enemy)

        -- destroy the bullet
        if v.dead then
            table.remove(firedBullets, i)
        end
    end
end

function love.keypressed(key)
    player:keypressed(key)
end