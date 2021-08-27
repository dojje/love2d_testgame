function love.load()
    target = {}

    target.x = 200
    target.y = 200 
    target.vel = 0
    target.weight = 0.01
    target.radius = 40

    gameFont = love.graphics.newFont(40)
    score = 0

    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    reset_all()
end

function love.update(dt)

end

function love.draw()
    if target.y - target.radius > window_height then
        game_over()
    end

    love.graphics.setColor(1, 0, 0)        
    love.graphics.circle("fill", target.x, target.y, target.radius)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. tostring(score), 0, 0)

    gravity_stuff()
end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 then
        local mouseToTarget = distance_between(x, y, target.x, target.y)
        if mouseToTarget <= target.radius then 
            add_score()
        end
    end
end

function distance_between(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function gravity_stuff()
    target.y = target.y + target.vel
    target.vel = target.vel + target.weight
end

function add_score() -- executes when the player clicked on a circle
    score = score + 1
    target.y = 100
    target.x = random_x_cord()
    target.vel = 0
    target.weight = target.weight + (0.01 / (target.weight * 100))
end

function reset_all() -- resets the game
    target.x = random_x_cord()
    target.y = 200 
    target.vel = 0
    target.weight = 0.01
    target.radius = 40

    score = 0
end

function random_x_cord()
    -- return math.random(0 + target.radius, window_width - target.radius)

    local maxtpcords = 150
    local xcord = math.random(target.x - target.radius - maxtpcords, target.x + target.radius + maxtpcords)

    if xcord + target.radius > window_width then 
        return xcord - maxtpcords
    end

    if xcord - target.radius < 0 then
        return xcord + maxtpcords
    end

    return xcord

end

function game_over()
    reset_all()
end
