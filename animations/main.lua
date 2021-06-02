function love.load()
    frames = {}
    image = love.graphics.newImage("jump_3.png")
    --[[ for i=1,5 do 
        table.insert(frames, love.graphics.newImage("jump" .. i .. ".png"))
    end ]]

    local frame_width = 117
    local frame_height = 233
    local max_frames = 5
    for i=0,1 do
        for j=0,2 do
            table.insert(frames, love.graphics.newQuad(1 + j * (frame_width + 2), 1 + i * (frame_height + 2), frame_width, frame_height, 
                                                    image:getWidth(), image:getHeight()))
            if #frames == max_frames then
                break
            end
        end
    end
    
    currentFrame = 1
end

function love.draw()
    love.graphics.draw(image, frames[math.floor(currentFrame)], 100, 100)
end

function love.update(dt)
    currentFrame = currentFrame + 10 * dt
    if currentFrame >= 6 then
        currentFrame = 1
    end
end