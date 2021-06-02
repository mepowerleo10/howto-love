function love.load()
    image = love.graphics.newImage("tileset.png")

    local image_width = image:getWidth()
    local image_height = image:getHeight()
    quad_width = (image_width / 3) - 2
    quad_height = (image_height / 2) - 2

    -- create the quads
    quads = {}
    for i = 0, 1 do
        for j = 0, 2 do
            table.insert(
                quads,
                love.graphics.newQuad(
                    1 + j * (quad_width + 2),
                    1 + i * (quad_height + 2),
                    quad_width,
                    quad_height,
                    image_width,
                    image_height
                )
            )
        end
    end

    tilemap = {
        {1, 6, 6, 2, 1, 6, 6, 2},
        {3, 0, 0, 4, 5, 0, 0, 3},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {4, 2, 0, 1, 2, 0, 1, 5},
        {1, 5, 0, 4, 5, 0, 4, 2},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {3, 0, 0, 1, 2, 0, 0, 3},
        {4, 6, 6, 5, 4, 6, 6, 5}
    }

    player = {
        image = love.graphics.newImage("player.png"),
        tile_x = 2,
        tile_y = 2
    }
end

function love.draw()
    for i, row in ipairs(tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(
                    image,
                    quads[tile],
                    j * quad_width,
                    i * quad_height
                )
            end
        end
    end

    love.graphics.draw(
        player.image,
        player.tile_x * quad_width,
        player.tile_y * quad_height
    )
end

function love.update()
end

function love.keypressed(key)
    local x = player.tile_x
    local y = player.tile_y

    if key == "left" then
        x = x - 1
    elseif key == "right" then
        x = x + 1
    elseif key == "up" then
        y = y - 1
    elseif key == "down" then
        y = y + 1
    end

    if love.keyboard.isDown("lctrl") then
        tilemap[y][x] = 0
    end
    if tile_is_empty(x, y) then
        player.tile_x = x
        player.tile_y = y
    end
end

function tile_is_empty(x, y)
    return tilemap[y][x] == 0
end
