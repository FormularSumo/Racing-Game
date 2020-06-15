Car = Class{}

function Car:init(x, y, radius) -- Creates Car
    self.x = x
    self.y = y
    self.dy = 0
    self.dx = 0
end

function Car:reset() -- Resets Car position and speed and randomises direction
    self.x = WINDOW_WIDTH / 2
    self.y = WINDOW_HEIGHT / 2
    self.dx = 0
    self.dy = 0
end

function Car:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y + paddle.height or paddle.y > then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Car:update(dt) -- Updates Car postion
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Car:render() -- Renders Car
    self.radius = self.original_radius / Scaling
    love.graphics.circle('fill', self.x, self.y, self.radius)
end