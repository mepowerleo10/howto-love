Shape = Object:extend()

function Shape:new(x, y, speed)
    self.x = x or 100
    self.y = y or 100
    self.speed = speed or 100
end

function Shape:update(dt)
    self.x = self.x + self.speed * dt
end