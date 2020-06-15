Class = require 'class'



    --Runs when the game first starts up, only once; used to initialize the game.

function love.load()
    love.window.setTitle('Racing Game')
    love.window.setMode(0, 0, {
        fullscreen = true,
        resizable = true,
        vsync = true
    })

    WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions() --As program is already fullscreen this finds out the resolution of the screen

    font50 = love.graphics.newFont(50)
    font80 = love.graphics.newFont(80)
end


function love.update(dt)


    if gamestate == 'play' or gamestate == 'serve' then
        if car:collides(player1) then
            ball.dx = ball.dx * -1.03 --Reverses x velocity, increasing it slightly
            ball.x = player1.x + player1.width + ball.radius / 2--Makes sure ball is not collding with paddle after it changes direction

            if ball.dy < 0 then
                ball.dy = math.random(30,400)
            else
                ball.dy = -math.random(30,400)
            end
            sounds['paddle_hit']:play()
        end

        if ball:collides(player2) then
            ball.dx = ball.dx * -1.05
            ball.x = player2.x - ball.radius / 2

            if ball.dy < 0 then
                ball.dy = math.random(10,150)
            else
                ball.dy = -math.random(10,150)
            end
            sounds['paddle_hit']:play()
        end

        --Invert Y and speed up X if touching ceiling or ground

        if ball.y >= WINDOW_HEIGHT  then
            ball.y = WINDOW_HEIGHT
            ball.dy = -ball.dy
            ball.dx = ball.dx * 1.03
        end

        player1:update(dt)
        player2:update(dt)
    end

    if gamestate == 'play' then
        ball:update(dt)
    end


function love.keypressed(key)
    --Escape exits fullscreen
    if key == 'escape' then
        love.window.setFullscreen(false)
        love.window.maximize()
    end
    --F11 toggles between fullscreen and maximised
    if key == 'f11' then
        if love.window.getFullscreen() == false then
            love.window.setFullscreen(true)
        else
            love.window.setFullscreen(false)
            love.window.maximize()
        end
    end
    --Space plays/pauses
    if key == 'space' then
        if gamestate == 'pause' or gamestate == 'serve' then
            gamestate = 'play'
        elseif gamestate == 'play' then
            gamestate = 'pause'
        else
            reset()
            gamestate = 'serve'
        end
    end
    --F5 resets program
    if key == 'f5' then 
        reset()
    end
end


--Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.

-- function love.draw()
--     love.graphics.setColor(255, 255, 255, 255)
--     love.graphics.setFont(font50)
--     --love.graphics.printf(Scaling,0,WINDOW_HEIGHT / 1.5 - 25,WINDOW_WIDTH,'center')
--     love.graphics.printf(
--         'Pong',                 -- text to render
--         0,                      -- starting X (0 as it's going to be centered based on WINDOW_WIDTH)
--         40,                     -- starting Y
--         WINDOW_WIDTH,           -- number of pixels to allign within
--         'center')               -- alignment mode, can be 'center', 'left', or 'right'
    
--     love.graphics.setFont(font80)
--     love.graphics.printf(P1Score,-400 / Scaling2,25,WINDOW_WIDTH,'center')
--     love.graphics.printf(P2Score,400 / Scaling2,25,WINDOW_WIDTH,'center')
--     player1:render()
--     player2:render()
--     ball:render()

--     if gamestate == 'pause' then
--         love.graphics.printf('Paused',0,WINDOW_HEIGHT / 2 + 20 * Scaling1,WINDOW_WIDTH ,'center')
--     elseif gamestate == 'serve' then
--         love.graphics.printf('Player ' .. tostring(Serving_player) .. "'s serve",0,WINDOW_HEIGHT / 2 + 20 * Scaling1,WINDOW_WIDTH ,'center')
--     elseif gamestate == 'done' then
--         love.graphics.printf('Player ' .. tostring(winner) .. " has won",0,WINDOW_HEIGHT / 2 + 20 * Scaling1,WINDOW_WIDTH ,'center')
--     end
--     love.graphics.setFont(font50)

--     if gamestate == 'pause' or gamestate == 'serve' then
--         love.graphics.printf('Space = play/pause',0,WINDOW_HEIGHT / 2 + 170,WINDOW_WIDTH ,'center')
--         love.graphics.printf('F5 = reset',0,WINDOW_HEIGHT / 2 + 230,WINDOW_WIDTH ,'center')
--         love.graphics.printf("1/2 = toggle AI",0,WINDOW_HEIGHT / 2 + 300,WINDOW_WIDTH ,'center')
--         love.graphics.print(player1.ai,player1.x + player1.width + 50,player1.y + 12.5)
--         love.graphics.printf(player2.ai,0,player2.y + 12.5,WINDOW_WIDTH - player2.width - 80,'right')
--     end

--     if gamestate == 'done' then
--         love.graphics.printf('Press space to play again',0,WINDOW_HEIGHT / 2 + 130,WINDOW_WIDTH,'center')
--     end

--     love.graphics.setColor(0, 255, 0, 255)
--     love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
--     --love.graphics.print(gamestate,50,50)
--     --love.graphics.print(player2.y,50,50)

-- end