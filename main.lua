-- built in love 0.10.2 in x64 architecture. 
-- 2D pong
local speed = 4
local reverse = -speed
local ball = { x = 600, y = 300, vx = -speed, vy = speed }

function love.load()
	-- Player Vars
	posY1 = 250 		-- Player 1 Y axis 
	posX = 20  			-- Player 1 Start point on the X axis. 
	pHeight = 100  		-- Player Height 
	pWidth = 20 		-- Player Width
	-- computer vars
	posY2 = 250 		-- Player 2 Y axis	
	pHeight2 = 100  	-- Player Height 
	pWidth2 = 20 		-- Player Width
	-- Ball Vars
	ballHeight = 10		-- Ball Height
	ballWidth = 10		-- Ball Width

	-- Score Vars
	BigFont = love.graphics.newFont("Chalet London Nineteen Seventy.otf", 22) -- Font type
	scoreP1 = 0			-- player 1 score
	scoreP2 = 0			-- player 2 score
	isdead = false
	screen_height = 300
end

function love.draw()
	--Players
	love.graphics.setColor(255,255,255,255) -- this color code is White.
	love.graphics.rectangle("fill", posX, posY1, pWidth, pHeight)    --player1
	love.graphics.rectangle("fill",love.graphics.getWidth()-40, posY2, pWidth2, pHeight2)  --player2
	
	--Ball
	love.graphics.setColor(0,255,0,255) -- this color code is blue.
	love.graphics.circle("fill", ball.x, ball.y, ballWidth, ballHeight)
	
	--Score
	love.graphics.setColor(255,255,255,255) -- this color code is White.
	love.graphics.setFont(BigFont)
	love.graphics.printf("Player 1 - "..scoreP1.."   Player 2 - ".. scoreP2, 0, 0, love.graphics.getWidth(), "center" )
end


function love.update(dt)
	if isdead == false then

-- Player movement logic
		--Player one movement
		if love.keyboard.isDown("w") then 
			posY1 = posY1 - 10
			if posY1 < 0 then 
				posY1 = 0
			end
		elseif love.keyboard.isDown("s") then
			posY1 = posY1 + 10
			if posY1 > love.graphics.getHeight()- pHeight then 
				posY1 = love.graphics.getHeight()- pHeight
			end
		end
		
		--Player2 movement logic
		if love.keyboard.isDown("up") then
			posY2 = posY2 - 10
			if posY2 < 0 then 
				posY2 = 0
			end
		elseif love.keyboard.isDown("down") then
			posY2 = posY2 + 10
			if posY2 > love.graphics.getHeight()- pHeight then 
				posY2 = love.graphics.getHeight()- pHeight
			end
		end

-- Ball Logic  
		-- This sets the primary direction of the ball to go towards player one
		ball.x = (ball.x + ball.vx)		-- Ball goes Left
		ball.y = (ball.y + ball.vy)		-- Ball goes Down

		-- if the ball hits the bottom of the screen then reverse the Y axis of the ball to make it go UP.
		if ball.y > love.graphics.getHeight() - ballHeight - 5 then
			ball.vy = ball.vy - 1
		end

		-- if the ball hits the top of the screen then reverse the Y axis of the ball to make it go DOWN.
		if ball.y < 15 then
			ball.vy = ball.vy + 1
		end

-- Collisions for Player and computer
		-- Player 1 Collisions
	    if ball.x <= 40 and (ball.y + ballHeight) >= posY1 and ball.y < (posY1 + pHeight) then
	    	ball.vx = math.abs(ball.vy)
		end

		-- Player 2 Collisions
	    if ball.x >= (love.graphics.getWidth() - 40) and (ball.y + ballHeight) >= posY2 and ball.y < (posY2 + pHeight2) then
	    	ball.vx = -math.abs(ball.vy)
		end

		-- S C O R I N G  ....  S Y S T E M 
		-- If the ball passes to the left, player 2 wins a point
		if ball.x < 0  then
			scoreP2 = scoreP2 + 1
			ball.x = 600
		end

		-- If the ball passes to the right, player 1 wins a point.
		if ball.x > love.graphics.getWidth() - ballHeight then
			scoreP1 = scoreP1 + 1
			ball.x = 600
		end	

		--When to stop 
		if scoreP1 == 6 then
			isdead = True
		elseif scoreP2 == 6 then
			isdead = True
		end
	end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.push('quit')
    end
end




