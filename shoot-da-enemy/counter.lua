Counter = Object:extend()

function Counter:new()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.hit = 0
    self.fired = 0
    self.missed = 0
end

function Counter:draw()
    love.graphics.print("Hit: " .. self.hit .."  Missed: " .. self.missed, self.x, self.y)
end

function Counter:update(dt)
    self.missed = self.fired - self.hit
end