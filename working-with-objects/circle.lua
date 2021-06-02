Circle = Shape:extend()

function Circle:new(x, y, r, speed)
    Circle.super.new(self, x, y, speed)
    self.r = r or 50
end

function Circle:draw()
    love.graphics.circle("line", self.x, self.y, self.r)    
end

function Circle:update(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y + self.speed * dt
end