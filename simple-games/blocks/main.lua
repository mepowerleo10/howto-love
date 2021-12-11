function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

  gridXCount = 10
  gridYCount = 18

  inert = {}
  for y = 1, gridYCount do
    inert[y] = {}
    for x = 1, gridXCount do
      inert[y][x] = ' '
    end
  end

  pieceStructures = {
    { -- line
      {
        {' ', ' ', ' ', ' '},
        {'i', 'i', 'i', 'i'},
        {' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', 'i', ' ', ' '},
        {' ', 'i', ' ', ' '},
        {' ', 'i', ' ', ' '},
        {' ', 'i', ' ', ' '}
      }
    },
    { -- square
      {
        {' ', ' ', ' ', ' '},
        {' ', 'o', 'o', ' '},
        {' ', 'o', 'o', ' '},
        {' ', ' ', ' ', ' '}
      }
    },
    { -- J
      {
        {' ', ' ', ' ', ' '},
        {'j', 'j', 'j', ' '},
        {' ', ' ', 'j', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', 'j', ' ', ' '},
        {' ', 'j', ' ', ' '},
        {'j', 'j', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {'j', ' ', ' ', ' '},
        {'j', 'j', 'j', ' '},
        {' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', 'j', 'j', ' '},
        {' ', 'j', ' ', ' '},
        {' ', 'j', ' ', ' '},
        {' ', ' ', ' ', ' '}
      }
    },
    { -- L
      {
        {' ', ' ', ' ', ' '},
        {'l', 'l', 'l', ' '},
        {'l', ' ', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', 'l', ' ', ' '},
        {' ', 'l', ' ', ' '},
        {' ', 'l', 'l', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', ' ', 'l', ' '},
        {'l', 'l', 'l', ' '},
        {' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {'l', 'l', ' ', ' '},
        {' ', 'l', ' ', ' '},
        {' ', 'l', ' ', ' '},
        {' ', ' ', ' ', ' '}
      }
    },
    { -- T
      {
        {' ', 't', ' ', ' '},
        {'t', 't', 't', ' '},
        {' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', 't', ' ', ' '},
        {'t', 't', ' ', ' '},
        {' ', 't', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', ' ', ' ', ' '},
        {'t', 't', 't', ' '},
        {' ', 't', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', 't', ' ', ' '},
        {' ', 't', 't', ' '},
        {' ', 't', ' ', ' '},
        {' ', ' ', ' ', ' '}
      }
    },
    { -- S
      {
        {' ', ' ', ' ', ' '},
        {' ', 's', 's', ' '},
        {'s', 's', ' ', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {'s', ' ', ' ', ' '},
        {'s', 's', ' ', ' '},
        {' ', 's', ' ', ' '},
        {' ', ' ', ' ', ' '}
      }
    },
    { -- Z
      {
        {' ', ' ', ' ', ' '},
        {'z', 'z', ' ', ' '},
        {' ', 'z', 'z', ' '},
        {' ', ' ', ' ', ' '}
      },
      {
        {' ', 'z', ' ', ' '},
        {'z', 'z', ' ', ' '},
        {'z', ' ', ' ', ' '},
        {' ', ' ', ' ', ' '}
      }
    }
  }
  pieceType = 1
  pieceRotation = 1
  pieceX = 3
  pieceY = 0
  pieceXCount = 4
  pieceYCount = 4
  
  timer = 0

  inert[8][5] = 'z'

  function canPieceMove(testX, testY, testRotation)
    for y = 1, pieceYCount do
      for x = 1, pieceXCount do
        if pieceStructures[pieceType][testRotation][y][x] ~= ' ' and (
          (testX + x) < 1 
          or (testX + x) > gridXCount
          or (testY + y ) > gridYCount
          or inert[testY + y][testX + x] ~= ' '
        ) then
          return false
        end
      end
    end

    return true
  end
end

function love.update(dt)
  timer = timer + dt
  if timer > 0.5 then
    timer = 0 -- reset the timer
    local testY = pieceY + 1
    if canPieceMove(pieceX, testY, pieceRotation) then
      pieceY = testY
    end
  end
end

function drawBlock(block, x, y)
  local colors = {
    [' '] = {.87, .87, .87},
    i = {.47, .76, .94},
    j = {.93, .91, .42},
    l = {.49, .85, .76},
    o = {.92, .69, .47},
    s = {.83, .54, .93},
    t = {.97, .58, .77},
    z = {.66, .83, .46},
  }

  local blockSize = 20
  local blockDrawSize = blockSize - 1
  local color = colors[block]

  love.graphics.setColor(color)
  love.graphics.rectangle(
    'fill',
    (x - 1) * blockSize,
    (y - 1) * blockSize,
    blockDrawSize,
    blockDrawSize
  )
end

function love.draw()
  for y = 1, gridYCount do
    for x = 1, gridXCount do
      local block =  inert[y][x]
      drawBlock(block, x, y)
    end
  end

  for y = 1, pieceYCount do
    for x = 1, pieceXCount do
      local block = pieceStructures[pieceType][pieceRotation][y][x]
      drawBlock(block, x + pieceX, y + pieceY)
    end
  end
end

function love.keypressed(key)
  if key == 'x' then
    local testRotation = pieceRotation + 1
    if testRotation > #pieceStructures[pieceType] then
      testRotation = 1
    end

    if canPieceMove(pieceX, pieceY, testRotation) then
      pieceRotation = testRotation
    end

  elseif key == 'z' then
    testRotation = pieceRotation - 1
    if testRotation < 1 then
      testRotation = #pieceStructures[pieceType]
    end

    if canPieceMove(pieceX, pieceY, testRotation) then
      pieceRotation = testRotation
    end

  elseif key == 'left' then
    testX = pieceX - 1
    if canPieceMove(testX, pieceY, pieceRotation) then
      pieceX = testX
    end

  elseif key == 'right' then
    testX = pieceX + 1
    if canPieceMove(testX, pieceY, pieceRotation) then
      pieceX = testX
    end

  elseif key == 'down' then
    pieceType = pieceType + 1
    if pieceType > #pieceStructures then
      pieceType = 1
    end
    pieceRotation = 1

  elseif  key == 'up' then
    pieceType = pieceType - 1
    if pieceType < 1 then
      pieceType = #pieceStructures
    end
    pieceRotation = 1
  end
end