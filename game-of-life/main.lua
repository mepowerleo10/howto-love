if arg[2] == "debug" then
  require("lldebugger").start()
end

local function T2D(w,h)
    local t={}
    for y=1,h do
        t[y]={}
        for x=1,w do
            t[y][x]=0
        end
    end
    return t
end

local Life = {
  new = function(self,w,h)
    return setmetatable({ w=w, h=h, gen=1, curr=T2D(w,h), next=T2D(w,h)}, {__index=self})
  end,
  set = function(self, coords, hoffset, voffset)
    for i = 1, #coords, 2 do
      self.curr[coords[i+1+hoffset]][coords[i+voffset]] = 1
    end
  end,
  change = function(self, coords)
    for i = 1, #coords, 2 do
        current = self.next[coords[i+1]][coords[i]]
        if current == 1 then
            next = 0
        else
            next = 1
        end
        self.next[coords[i+1]][coords[i]] = next
        print(self.next[coords[i+1]][coords[i]])
    end
  end,
  evolve = function(self)
    local curr, next = self.curr, self.next
    local ym1, y, yp1 = self.h-1, self.h, 1
    for i = 1, self.h do
      local xm1, x, xp1 = self.w-1, self.w, 1
      for j = 1, self.w do
        local sum = curr[ym1][xm1] + curr[ym1][x] + curr[ym1][xp1] +
                    curr[y][xm1] + curr[y][xp1] +
                    curr[yp1][xm1] + curr[yp1][x] + curr[yp1][xp1]
        next[y][x] = ((sum==2) and curr[y][x]) or ((sum==3) and 1) or 0
        xm1, x, xp1 = x, xp1, xp1+1
      end
      ym1, y, yp1 = y, yp1, yp1+1
    end
    self.curr, self.next, self.gen = self.next, self.curr, self.gen+1
  end,
  render = function(self)
    for y = 1, self.h do
      for x = 1, self.w do
        if self.curr[y][x] == 0 then
            love.graphics.rectangle(
                "fill",
                (x - 1) * blockSize,
                (y - 1) * blockSize,
                blockDrawSize,
                blockDrawSize
            )
        else
            love.graphics.rectangle(
                "line",
                (x - 1) * blockSize,
                (y - 1) * blockSize,
                blockDrawSize,
                blockDrawSize
            )

        end

        love.graphics.print(
          love.getVersion(),
          0,
          0
        )
      end
    end
  end
}

function love.load()

    gospersGliderGun = {
        1,6, 2,6, 1,7, 2,7,

        11,6, 11,7, 11,8,
        12,5, 12,9,
        13,4, 13,10,
        14,4, 14,10,
        15,7,
        16,5, 16,9,
        17,6, 17,7, 17,8,
        18,7,

        21,4, 21,5, 21,6,
        22,4, 22,5, 22,6,
        23,3, 23,7,
        25,2, 25,3, 25,7, 25,8,

        35,4, 35,5,
        36,4, 36,5
    }

    run = false

    blockSize = 10
    blockDrawSize = blockSize - 1

    width = love.graphics.getWidth() / blockSize
    height = love.graphics.getHeight() / blockSize
    life = Life:new(width, height)
    -- life:set({ 3,2, 4,2, 4,3, 3,3 })
    life:set(gospersGliderGun, 0, 0)
end

function love.update(dt)
    if run then
        life:evolve()
    end
end

function love.draw()
    life:render()
end

function love.mousereleased(x, y, button)
    if button == 1 then
        --[[ print(math.ceil(x / blockSize) .. ','.. math.ceil(y / blockSize) .. '\n')
        life.curr[math.ceil(x / blockSize)][math.ceil(y / blockSize)] = 1
        life:change({ math.ceil(x / blockSize), math.ceil(y / blockSize) }) ]]

        run = not run
    end
end