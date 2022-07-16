local Ball = {
  radius = 8,
  pos_x = 300,
  pos_y = 300,
  speed_x = 300,
  speed_y = 300
}
function Ball.update(dt)
  Ball.pos_x = Ball.pos_x + Ball.speed_x * dt
  Ball.pos_y = Ball.pos_y + Ball.speed_y * dt
end
function Ball.draw()
  love.graphics.circle(
    "fill", Ball.pos_x, Ball.pos_y, Ball.radius)
end

return Ball