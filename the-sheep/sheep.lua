Sheep = Object:extend()

function Sheep:new(x, y, sx, sy, r, path)
    self.path = path or "sheep.png"
    self.x = x or 100
    self.y = y or 100
    self.sx = sx or 1
    self.sy = sy or 1
    self.r = r or 0
    self.image = love.graphics.newImage(self.path)
    self.w = self.image:getWidth()
    self.h = self.image:getHeight()
    self.speed = 75
end

function Sheep:draw()
    love.graphics.setColor(1, 0.78, 0.15, 0.5)
    love.graphics.draw(
        self.image, 
        self.x, 
        self.y, 
        self.r, 
        self.sx, 
        self.sy, 
        self.w/2,
        self.h/2)
end

function Sheep:update(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y + self.speed * dt

    if (self.x % 5 == 0) or (self.y % 5 == 0) then
        self.r = self.r + 10 * dt
    end
end