Rectangle = Shape:extend()

function Rectangle:new(x, y, w, h, speed)
    Rectangle.super.new(self, x, y, speed)
    self.w = w or 200
    self.h = h or 150
end

function Rectangle:update(dt)
    self.x = self.x + self.speed * dt
end

function Rectangle:draw() 
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end