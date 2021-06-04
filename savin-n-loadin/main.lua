function love.load()
    --    Object = require "classic"
    lume = require "lume"
    kb = love.keyboard -- it is tedious writing it over n' over again
    player = {
        x = 100,
        y = 100,
        speed = 200,
        size = 25,
        face = love.graphics.newImage("face.png"),
    }
    coins = {}
    loadGame()
end

function love.draw()
    -- the players and coins are going to be circles
    love.graphics.circle("line", player.x, player.y, player.size)
    love.graphics.draw(
        player.face,
        player.x,
        player.y,
        0,
        1,
        1,
        -- setting the anchor, as the centre of the face
        player.face:getWidth() / 2,
        player.face:getHeight() / 2
    )

    -- drawing the coins
    for i,v in ipairs(coins) do
        love.graphics.circle("line", v.x, v.y, v.size)
        love.graphics.draw(
            v.image,
            v.x,
            v.y,
            0,
            1,
            1,
            v.image:getWidth() / 2,
            v.image:getHeight() / 2
        )
    end
end

function love.update(dt)
    -- make the player movable by the keyboard
    if kb.isDown("left") then
        player.x = player.x - player.speed * dt
    elseif kb.isDown("right") then
        player.x = player.x + player.speed * dt
    end

    -- To move diagonally, we must separate the keyboard events
    if kb.isDown("up") then
        player.y = player.y - player.speed * dt
    elseif kb.isDown("down") then
        player.y = player.y + player.speed * dt
    end

    for i=#coins,1,-1 do
        if isCollision(player, coins[i]) then
            table.remove(coins, i)
            player.size = player.size + 1
        end
    end
end

function isCollision(c1, c2) 
    distance = (c1.x - c2.x)^2 + (c1.y - c2.y)^2
    distance = math.sqrt(distance)

    return distance < (c1.size + c2.size)
end

function saveGame()
    data = {}
    data.player = {
        x = player.x,
        y = player.y,
        size = player.size
    }

    data.coins = {}
    for i,v in ipairs(coins) do
        data.coins[i] = {x = v.x, y = v.y}
    end

    serialized = lume.serialize(data)
    love.filesystem.write("savedata", serialized)
end

function loadGame()
    if love.filesystem.getInfo("savedata") then
        file = love.filesystem.read("savedata")
        data = lume.deserialize(file)

        -- applying the data
        player.x = data.player.x
        player.y = data.player.y
        player.size = data.player.size

        for i,v in ipairs(data.coins) do
            coins[i] = {
                x = v.x,
                y = v.y,
                size = 10,
                image = love.graphics.newImage("dollar.png")
            }
        end
    else 
        for i=1,25 do 
            table.insert(
                coins,
                {
                    x = love.math.random(50, 650),
                    y = love.math.random(50, 650),
                    size = 10,
                    image = love.graphics.newImage("dollar.png")
                }
            )
        end
    end
end

function love.keypressed(key)
    if key == "f1" then
        saveGame()
    elseif key == "f2" then
        love.filesystem.remove("savedata")
        love.event.quit("restart")
    end
end