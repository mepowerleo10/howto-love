Bullet = Object:extend()

function Bullet:new(x, y)
    self.image = love.graphics.newImage("bullet.png")
    self.x = x
    self.y = y
    self.speed = 700

    -- Needed to check for collision
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Bullet:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bullet:update(dt)
    self.y = self.y + self.speed * dt

    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()

    if self.y > window_height then
        self.dead = true
        -- love.load()
    end
end

function Bullet:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + obj.height

    if  self_right > obj_left and
        self_left < obj_right and
        self_bottom > obj_top and
        self_top < obj_bottom then
            
        self.dead = true
        counter.hit = counter.hit + 1
        -- increase the enemy speed
        if obj.speed > 0 then
            obj.speed = obj.speed + 50
        else
            obj.speed = obj.speed - 50
        end
    end
end