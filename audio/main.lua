function love.load()
    song = love.audio.newSource("song.ogg", "stream")
    song:setLooping(true)
    song:play()
    
    love.audio.setEffect("myEffect", {type = "reverb"})
    sfx = love.audio.newSource("sfx.ogg", "static")
end

function love.draw()
end

function love.update(dt)
end

function love.keypressed(key)
    if key == "space" then
        if not sfx:isPlaying() then
            sfx:play()
        else
            sfx:stop()
        end
    end
end