function takeCard(hand)
    table.insert(hand, table.remove(deck, love.math.random(#deck)))
end

function love.load()
    images = {}
    for nameIdx, name in ipairs({
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
        'pip_heart', 'pip_diamond', 'pip_club', 'pip_spade',
        'mini_heart', 'mini_diamond', 'mini_club', 'mini_spade',
        'card', 'card_face_down',
        'face_jack', 'face_queen', 'face_king'
    }) do
        images[name] = love.graphics.newImage('images/' .. name .. '.png')
    end
    
    deck = {}
    for suitIdx, suit in ipairs({'club', 'diamond', 'heart', 'spade'}) do
        for rank = 1, 13 do
            table.insert(deck, {suit = suit, rank = rank})
            -- TODO: Remove
            print('suit: ' .. suit .. ', rank: ' .. rank)
        end
    end
    -- TODO: Remove
    print('Total no. of cards in deck: ' .. #deck)

    playerHand = {}

    -- Dealing the dealer's hand
    dealerHand = {}
    for i = 1, 2 do
        takeCard(dealerHand)
    end

    roundOver = false

    love.graphics.setBackgroundColor(1, 1, 1)

    function isMouseInButton(btn)
        local mouseX = love.mouse.getX()
        local mouseY = love.mouse.getY()
        
        return mouseX>= btn.x
        and mouseX < btn.x + btn.width
        and mouseY >= btn.y
        and mouseY < btn.y + btn.height
    end

    local stdWidth = 53
    local stdHeight = 25
    local yAxis = 230
    hitButton = {
        x = 10,
        y = yAxis,
        width = stdWidth,
        height = stdHeight,
        textOffsetX = 16,
        text = 'Hit!',
    }
    standButton = {
        x = 70,
        y = yAxis,
        width = stdWidth,
        height = stdHeight,
        textOffsetX = 8,
        text = 'Stand',
    }
    playAgainButton = {
        x = 10,
        y = yAxis,
        width = 113,
        height = stdHeight,
        textOffsetX = 24,
        text = 'Play Again!',
    }
end

function getTotal(hand)
    local total = 0
    local hasAce = false

    for cardIdx, card in ipairs(hand) do
        if card.rank > 10 then
            total = total + 10
        else
            total = total + card.rank
        end

        if card.rank == 1 then
            hasAce = true
        end
    end

    if hasAce and (total <= 11) then
        total = total + 10
    end 
    return total
end

function handHasWon(thisHand, otherHand)
    local thisTotal = getTotal(thisHand)
    local otherTotal = getTotal(otherHand)
    return thisTotal <= 21 and (otherTotal > 21 
                or thisTotal > otherTotal)
end

function drawCard(card, x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(images.card, x, y)

    local cardWidth = 53
    local cardHeight = 73

    if card.suit == 'heart' or card.suit == 'diamond' then
        love.graphics.setColor(.89, .06, .39)
    else
        love.graphics.setColor(.2, .2, .2)
    end

    local function drawCorner(image, offsetX, offsetY)
        love.graphics.draw(
            image, 
            x + offsetX, 
            y + offsetY
        )
        love.graphics.draw(
            image,
            x + cardWidth - offsetX,
            y + cardHeight - offsetY,
            0,
            -1
        )
    end

    local numOffsetX = 3
    local numOffsetY = 4
    drawCorner(images[card.rank], numOffsetX, numOffsetY)

    local suitOffsetX = numOffsetX
    local suitOffsetY = numOffsetY + 10
    local suitImage = images['mini_' .. card.suit]
    drawCorner(suitImage, suitOffsetX, suitOffsetY)

    if card.rank > 10 then
        local faceImage

        if card.rank == 11 then
            faceImage = images.face_jack
        elseif card.rank == 12 then
            faceImage = images.face_queen
        elseif card.rank == 13 then
            faceImage = images.face_king
        end
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(faceImage, x + 12, y + 11)

    else
        local pipImage = images['pip_' .. card.suit]
        local pipWidth = 11

        local xLeft = 11
        local xMid = 21
        local yTop = 7
        local yMid = 31
        local yThird = 19
        local yQtr = 23

        local function drawPip(pipImage, offsetX, offsetY, mirrorX, mirrorY)
            local pipWidth = pipImage:getWidth()
            love.graphics.draw(
                pipImage,
                x + offsetX,
                y + offsetY
            )

            if mirrorX then
                love.graphics.draw(
                    pipImage,
                    x + cardWidth - offsetX - pipWidth,
                    y + offsetY
                )
            end
            if mirrorY then
                love.graphics.draw(
                    pipImage,
                    x + offsetX + pipWidth,
                    y + cardHeight - offsetY,
                    0,
                    -1
                )
            end
            if mirrorX and mirrorY then
                love.graphics.draw(
                    pipImage,
                    x + cardWidth - offsetX,
                    y + cardHeight - offsetY,
                    0,
                    -1
                )
            end
        end

        if card.rank == 1 then
            drawPip(pipImage, xMid, yMid)
        elseif card.rank == 2 then
            drawPip(pipImage, xMid, yTop, false, true)
        elseif card.rank == 3 then
            drawPip(pipImage, xMid, yTop, false, true)
            drawPip(pipImage, xMid, yMid)
        elseif card.rank == 4 then
             drawPip(pipImage, xLeft, yTop, true, true)
        elseif card.rank == 5 then
            drawPip(pipImage, xMid, yMid)
            drawPip(pipImage, xLeft, yTop, true, true)
        elseif card.rank == 6 then
            drawPip(pipImage, xLeft, yTop, true, true)
            drawPip(pipImage, xLeft, yMid, true)
        elseif card.rank == 7 then
            drawPip(pipImage, xLeft, yTop, true, true)
            drawPip(pipImage, xLeft, yMid, true)
            drawPip(pipImage, xMid, yThird)
        elseif card.rank == 8 then
            drawPip(pipImage, xLeft, yTop, true, true)
            drawPip(pipImage, xLeft, yMid, true)
            drawPip(pipImage, xMid, yThird, false, true)
        elseif card.rank == 9 then
            drawPip(pipImage, xLeft, yTop, true, true)
            drawPip(pipImage, xLeft, yQtr, true, true)
            drawPip(pipImage, xMid, yMid)
        elseif card.rank == 10 then
            drawPip(pipImage, xLeft, yTop, true, true)
            drawPip(pipImage, xLeft, yQtr, true, true)
            drawPip(pipImage, xMid, 16, false, true)
        end
    end
end

function love.draw()
    local output = {}
    local cardSpacing = 60
    local marginX = 10

    for cardIdx, card in ipairs(dealerHand) do
        local dealerMarginY = 30
        if not roundOver and cardIdx == 1 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(images.card_face_down, marginX, dealerMarginY)
        else
            drawCard(card, ((cardIdx - 1) * cardSpacing) + marginX, dealerMarginY)
        end
    end

    for cardIdx, card in ipairs(playerHand) do
        drawCard(card, ((cardIdx - 1) * cardSpacing) + marginX, 140)
    end

    local function drawButton(btn)
        local buttonColor = {1, 0.5, 0.2}
        local hoverColor = {1, 0.8, 0.3}
        local buttonFontColor = {1, 1, 1}

        if isMouseInButton(btn) then
            love.graphics.setColor(hoverColor)
        else
            love.graphics.setColor(buttonColor)
        end        
        love.graphics.rectangle('fill', btn.x, btn.y, btn.width, btn.height)
        love.graphics.setColor(buttonFontColor)
        love.graphics.print(btn.text, btn.x + btn.textOffsetX, btn.y + 6)

        button = {
            x = x,
            y = y,
            width = width,
            height = height,
            text = text,
            textOffsetX = textOffsetX,
            buttonColor = buttonColor,
            hoverColor = hoverColor,
        }
        return button
    end

    love.graphics.setColor(0, 0, 0)
    if roundOver then
        love.graphics.print('Total: ' .. getTotal(dealerHand), marginX, 10)
        
        local function showWinner(message)
            love.graphics.print(message, marginX, 268)
        end

        if handHasWon(playerHand, dealerHand) then
            showWinner('Player Wins')
        elseif handHasWon(dealerHand, playerHand) then
            showWinner('Dealer Wins')
        else
            showWinner('Draw')
        end

        drawButton(playAgainButton)
    else
        love.graphics.print('Total: ?', marginX, 10)
        drawButton(hitButton)
        drawButton(standButton)
    end

    love.graphics.print('Total: ' .. getTotal(playerHand), marginX, 120)
end

function love.keypressed(key)
    if key == 'r' then
        love.load()
    end
    
    if not roundOver then
        if key == 'space' then
            takeCard(playerHand)
            if getTotal(playerHand) > 21 then
                roundOver = true
            end
        elseif key == 'return' then
            roundOver = true
        end
        
        if roundOver then
            while getTotal(dealerHand) < 17 do
                takeCard(dealerHand)
            end
        end
    end
end

function love.mousereleased()
    if not roundOver then
        if isMouseInButton(hitButton) then
            takeCard(playerHand)
            if getTotal(playerHand) > 21 then
                roundOver = true
            end
        elseif isMouseInButton(standButton) then
            roundOver = true
        end
        
        if roundOver then
            while getTotal(dealerHand) < 17 do
                takeCard(dealerHand)
            end
        end
    elseif isMouseInButton(playAgainButton) then
        print('yup')
        love.load()
    end
end