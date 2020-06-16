Class = require 'class'


Virtual_width = 1920
Virtual_height = 1080


local background = love.graphics.newImage('background.png')


function love.load()
    love.window.setTitle('Racing Game')
    
    love.window.setMode(0, 0, {
        fullscreen = true,
        resizable = true,
        vsync = true
    })

    font30 = love.graphics.newFont(30)
    font50 = love.graphics.newFont(50)
    font80 = love.graphics.newFont(80)

    sounds = {
        ['Intense music'] = love.audio.newSource('Possible soundtrack.mp3', 'static'),
    }
    
    sounds['Intense music']:play()

    master_volume = 1 -- Maximum volume for all sounds

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
    -- if key == 'space' then
    --     if gamestate == 'pause' or gamestate == 'serve' then
    --         gamestate = 'play'
    --     elseif gamestate == 'play' then
    --         gamestate = 'pause'
    --     else
    --         reset()
    --         gamestate = 'serve'
    --     end
    -- end
    -- --F5 resets program
    if key == 'f5' then 
        reset()
    end
    if key == 'm' then 
        if master_volume > 0 then
            master_volume = 0
        else
            master_volume = 1
        end
    end
end


--Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.

function love.draw()
   love.graphics.draw(background, 0, 0)
   love.graphics.setFont(font30)
   love.graphics.printf('Volume: ' .. master_volume,0,0,Virtual_width,'right')
end

function love.update()
    love.audio.setVolume(master_volume)
end