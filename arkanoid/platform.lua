local Platform = {
  pos_x = 500,
  pos_y = 500,
  speed_x = 300,
  width = 100,
  height = 10
}

function Platform.update(dt)
  if love.keyboard.isDown("right") then
    Platform.pos_x = Platform.pos_x + Platform.speed_x * dt
  end

  if love.keyboard.isDown("left") then
    Platform.pos_x = Platform.pos_x - Platform.speed_x * dt
  end
end

function Platform.draw()
  love.graphics.rectangle(
    "line",
    Platform.pos_x, Platform.pos_y,
    Platform.width, Platform.height
  )
end

return Platform