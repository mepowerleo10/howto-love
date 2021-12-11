function love.load()
    love.graphics.setBackgroundColor(.14, .36, .46)
    screenHeight = love.graphics.getHeight()
    screenWidth = love.graphics.getWidth()
    birdY = ((screenHeight / 2) - 100) % screenHeight
    birdX = 62
    birdSpeed = 0
    birdWidth = 30
    birdHeight = 25

    pipeWidth = 54
    pipeSpaceHeight = 100
    pipeSpeed = 60

    function getRandomPipeSpaceY()
        local pipeSpaceMinY = 54
        local pipeSpaceY = love.math.random(
            pipeSpaceMinY, 
            screenHeight - pipeSpaceHeight - pipeSpaceMinY
        )
        return pipeSpaceY
        -- pipeX = (screenWidth --[[ - pipeWidth ]])
    end

    pipes = {}
    for i=1,4,1 do
        table.insert(pipes, {
            x = 200 * i,
            spaceY = getRandomPipeSpaceY()
        })
    end

    score = 0
end

drawPipe = function (pipeX, pipeSpaceY)
    love.graphics.rectangle(
        'fill', 
        pipeX, 
        0, 
        pipeWidth, 
        pipeSpaceY
    )
    love.graphics.rectangle(
        'fill',
        pipeX,
        pipeSpaceY + pipeSpaceHeight,
        pipeWidth,
        screenWidth - pipeSpaceY - pipeSpaceHeight
    )
end

function love.draw()
    --[[ love.graphics.setColor(.14, .36, .46)
    love.graphics.rectangle(
        'fill', 0, 0, 
        love.graphics.getWidth(), love.graphics.getHeight()
    ) ]]

    -- Draw a yellow block for a bird
    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight, 5, 5)

    love.graphics.setColor(.37, .82, .28)

    for pipeIdx, pipe in ipairs(pipes) do
        drawPipe(pipe.x, pipe.spaceY)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. score, 20, 20, 0, 1, 1)
end

-- the bird is colliding if
function birdIsCollidingWith()
    -- the left edge of the bird is to the left of the right edge of the pipe
    if birdX < (pipe.x + pipeWidth) and
        -- the right edge of the bird is to the right of the left edge of the pipe
        (birdX + birdWidth) > pipe.x and
        (   
            -- the top edge of the bird is above the bottom edge of the first pipe segment
            birdY < pipe.spaceY or 
            -- the bottom edge of the bird is below the top edge of the second pipe segment
            (birdY + birdHeight) > (pipe.spaceY + pipeSpaceHeight)
        ) then
            return true
        end 
end

function love.update(dt)
    birdSpeed = birdSpeed + (516 * dt)
    birdY = birdY + (birdSpeed * dt)

    -- pipeX = pipeX - (60 * dt)

    -- if (pipeX + pipeWidth) < 0 then
    --     resetPipe()
    -- end

    -- checkCollision()
    for pipeIdx=#pipes, 1, -1 do
        pipe = pipes[pipeIdx]
        pipe.x = pipe.x - (pipeSpeed * dt)
        
        if (pipe.x + pipeWidth) < 0 then
            pipe.x = screenWidth
        end

        if birdX > (pipe.x + pipeWidth) then
            score = math.ceil(score + 1 * dt)
        end

        if birdIsCollidingWith(pipe) then
            love.load()
        end
    end

    if birdY > screenHeight then
        love.load()
    end
end

function love.keypressed(key)
    if key == "r" then
        love.load()
        return
    end
    if birdY > 0 then
        birdSpeed = -165        
    end
end