--[[
	CS50 - GD50 - Pong Game

	Student: Rodrigo Ferrero

	Pong is originally made in 1972 and is considered
	the grandfather of games.

	This is a study of the implementation of the game 
	in lua programming language.
]]

--[[
	Requires
]]
--	push library allow to draw the game at a virtual resolution
--	https://github.com/Ulydev/push
push = require 'push'

--	class library allow to use classes and objects in lua
--	https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

--	calling the classes 
require 'Paddle'
require 'Ball'

--[[
	Global Variables
]]
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

--[[
	Game
]]

--[[
	Runs when the game first runs, only once
	The bootstrap of the game
]]
function love.load()
	
	--	setting filter to point blank, to take out the blurry from virtualization
	love.graphics.setDefaultFilter('nearest', 'nearest')
	
	--	setting the current time to get a random number for our game	
	math.randomseed(os.time())

	--	setting the title of the screen
	love.window.setTitle("Super Pong!")
	
	--	setting the fonts of the game
	smallfont = love.graphics.newFont('font.ttf', 8)
	scoreFont = love.graphics.newFont('font.ttf', 32)
	victoryFont = love.graphics.newFont('font.ttf', 24)

	--	setting the font to use
	love.graphics.setFont(smallfont)
	
	--	setting the virtualization of the window, to make it look like old SNES
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})

	--	creating the table of sounds for the game
	sounds = {
		['hit_paddle'] = love.audio.newSource('hit_paddle.wav', 'static'),
		['hit_wall'] = love.audio.newSource('hit_wall.wav', 'static'),
		['point_scored'] = love.audio.newSource('point_scored.wav', 'static')
	}
	
	--	creating the objects paddle for both players
	player1 = Paddle(5, 30, 5, 20)
	player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

	--	creating the object ball
	ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

	--	setting the initial score on both players
	player1score = 0
	player2score = 0

	-- setting up the track of the winner player
	winner = 0

	--	setting the initial player to random
	servingPlayer = math.random(2) == 1 and 1 or 2

	--	setting the side of the ball based on the initial player
	if servingPlayer == 1 then
		ball.dx = 150
	else
		ball.dx = -150
	end

	--	setting the game in 'start' mode
	gamestate = 'start'
end

--[[
	Runs every frame
	dt is for delta time
]]
function love.update(dt)

	--	keeps the track of the score
	--	send the ball to the opposite direction of the player who scored
	if ball.x < 0 then
		player2score = player2score + 1
		servingPlayer = 1
		ball:reset()
		ball.dx = 150
		
		sounds['point_scored']:play()
		
		--	conditional to know if player 2 won
		if player2score >= 3 then
			gamestate = 'victory'
			winner = 2
			ball:reset()
		else
			gamestate = 'serve'
		end
	end
	if ball.x > VIRTUAL_WIDTH - 4 then
		player1score = player1score + 1
		servingPlayer = 2
		ball:reset()
		ball.dx = -150

		sounds['point_scored']:play()

		--	conditional to know if player 1 won
		if player1score >= 3 then
			gamestate = 'victory'
			winner = 1
			ball:reset()
		else
			gamestate = 'serve'
		end
	end

	--	uses the input of the user to update the vertical position of the player1
	if love.keyboard.isDown('w') then
		player1.dy = -PADDLE_SPEED
	elseif love.keyboard.isDown('s') then
		player1.dy = PADDLE_SPEED
	else
		player1.dy = 0
	end

	--	uses the input of the user to update the vertical position of the player2
	if love.keyboard.isDown('up') then
		player2.dy = -PADDLE_SPEED
	elseif love.keyboard.isDown('down') then
		player2.dy = PADDLE_SPEED
	else
		player2.dy = 0
	end

	-- moves the ball if the game starts
	if gamestate == 'play' then
		ball:update(dt)
	end

	--	detect collision on paddles
	if ball:collide(player1) then
		ball.dx = -ball.dx * 1.2
		
		sounds['hit_paddle']:play()
	end
	if ball:collide(player2) then
		ball.dx = -ball.dx * 1.2

		sounds['hit_paddle']:play()
	end

	--	detect if the balls go offscreen on top or bottom
	if ball.y <= 0 then
		ball.dy = -ball.dy
		ball.y = 0

		sounds['hit_wall']:play()
	end
	if ball.y >= VIRTUAL_HEIGHT - 4 then
		ball.dy = -ball.dy
		ball.y = VIRTUAL_HEIGHT - 4

		sounds['hit_wall']:play()
	end


	-- players update based on dt
	player1:update(dt)
	player2:update(dt)
end

--[[
	Keyboard handling, called each frame
	key is the key pressed so we can access
]]
function love.keypressed(key)

	--	condition to verify if the 'esc' key is pressed to close the game
	if key =='escape' then
		--	end the game if the event occurs
		love.event.quit()
	--	condition to change the gamestate if 'enter' is pressed
	elseif key == 'enter' or key == 'return' then
		if gamestate == 'start' then
			gamestate = 'serve'
		elseif gamestate == 'serve' then
			gamestate = 'play'
		elseif gamestate == 'victory' then
			player1score = 0
			player2score = 0
			winner = 0
			gamestate = 'start'
		end
	end
end

--[[
	Called after update, used to draw anything in the screen
]]
function love.draw()

	--	push virtualization initialized
	push:apply('start')

	--	draw the background in colour gray
	love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

	--	set up the base font of the game
	love.graphics.setFont(smallfont)

	--	draw the message of each state of the game
	if gamestate == 'start' then
		love.graphics.printf("Welcome to Super Pong!", 0, 20, VIRTUAL_WIDTH, 'center')
		love.graphics.printf("Press Enter to play!", 0, 32, VIRTUAL_WIDTH, 'center')
	elseif gamestate == 'serve' then
		love.graphics.printf("Player " .. tostring(servingPlayer) .. "'s turn!", 0, 20, VIRTUAL_WIDTH, 'center')
		love.graphics.printf("Press Enter to serve!", 0, 32, VIRTUAL_WIDTH, 'center')
	elseif gamestate == 'victory' then
		love.graphics.setFont(victoryFont)
		love.graphics.printf("Player " .. tostring(winner) .. " wins!", 0, 20, VIRTUAL_WIDTH, 'center')
		love.graphics.setFont(smallfont)
		love.graphics.printf("Press Enter to play!", 0, 52, VIRTUAL_WIDTH, 'center')
	end
	
	--	draw the score of the game
	love.graphics.setFont(scoreFont)
	love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 30, VIRTUAL_HEIGHT - 40)
	love.graphics.setFont(smallfont)
	love.graphics.print('x', VIRTUAL_WIDTH / 2 - 1.5, VIRTUAL_HEIGHT - 25)
	love.graphics.setFont(scoreFont)
	love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 14, VIRTUAL_HEIGHT - 40)
	
	--	draw the paddles 
	player1:render()
	player2:render()
	
	--	draw the ball
	ball:render()

	--	draw FPS rate on screen
	displayFPS()
	
	--	push virtualization must switch to end state
	 push:apply('end')
end

--[[
	Function to show the FPS on screen
]]
function displayFPS()
	love.graphics.setFont(smallfont)
	love.graphics.setColor(0 / 255, 255 / 255, 0 / 255, 255 / 255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 20, 10)
end