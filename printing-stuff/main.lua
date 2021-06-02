function love.load()
    fruits = {"apple", "pear", "orange"}
end

function love.update()
    if love.keyboard.isDown("down") then
        table.insert(fruits, "etc...")
    end
end

function love.draw()
    for i=1,#fruits do
        love.graphics.print(fruits[i], 100, 100 + 50 * i)
    end
end