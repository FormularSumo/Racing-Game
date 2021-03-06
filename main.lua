Class = require 'class'
push  = require 'push'

VIRTUAL_WIDTH = 1920
VIRTUAL_HEIGHT = 1080


local background = love.graphics.newImage('background.png')
car1 = love.graphics.newImage('car 1.png')
car2 = love.graphics.newImage('car 2.png')
car3 = love.graphics.newImage('car 3.png')
car9 = love.graphics.newImage('car 9.png')


function love.load()
    love.window.setTitle('Racing Game')
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 0, 0, {
        vsync = true,
        fullscreen = true,
        resizable = true
    })

    font30 = love.graphics.newFont(30)
    font50 = love.graphics.newFont(50)
    font80 = love.graphics.newFont(80)

    Intense_music = love.audio.newSource('Possible soundtrack.mp3', 'static')
    
    Intense_music:setLooping(true)
    Intense_music:play()

    master_volume = 100 -- Maximum volume for all sounds
    mute = false

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
    -- m toggles mute
    if key == 'm' then 
        if love.audio.getVolume() > 0 then
            mute = true
        else
            mute = false
        end
    end
end


--Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.

function love.draw()
    push:start()

    love.graphics.draw(background, 0, 0)
    love.graphics.setFont(font30)
    love.graphics.printf('Volume: ' .. math.abs(math.ceil(love.audio.getVolume()*100-0.5)),0,0,VIRTUAL_WIDTH,'right')

    push:finish()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    -- + increases volume, - decreases it
    if love.keyboard.isDown("=") then
        master_volume = master_volume + dt * 15
        mute = false
    end
    if love.keyboard.isDown("-") then
        master_volume = master_volume - dt * 15
        mute = false
    end

    --Makes sure volume isn't above 100 or bellow 0
    if master_volume > 100 then
        master_volume = 100
    end
    if master_volume < 0 then
        master_volume = 0
    end

    if mute == false then
        love.audio.setVolume(master_volume / 100)
    else 
        love.audio.setVolume(0)
    end
end