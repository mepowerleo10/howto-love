local Bricks = {
  current_level_bricks = {},
  std_width = 50,
  std_height = 30,
  rows = 8,
  columns = 11
}

function Bricks.new_brick(x, y, w, h)
  return {
    pos_x = x,
    pos_y = y,
    width = w or Bricks.std_width,
    height = h or Bricks.std_height
  }
end

function Bricks.draw_brick(brick)
  love.graphics.rectangle(
    "line",
    brick.pos_x, brick.pos_y,
    brick.width, brick.height
  )
end

function Bricks.update_brick(brick, dt)  
end

function Bricks.add_to_current_level_bricks(brick)
  table.insert(Bricks.current_level_bricks, brick)
end

function Bricks.draw()
  for _, brick in ipairs(Bricks.current_level_bricks) do
    Bricks.draw_brick(brick)
  end  
end

function Bricks.update(dt)
  for _, brick in ipairs(Bricks.current_level_bricks) do
    Bricks.update_brick(brick, dt)
  end
end

return Bricks