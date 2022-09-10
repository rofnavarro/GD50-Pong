--[[
	CS50 - GD50 - Pong Game

	Student: Rodrigo Ferrero

	Pong is originally made in 1972 and is considered
	the grandfather of games.

	This is a study of the implementation of the game 
	in lua programming language.
]]

--	Requires
	--	push library allow to draw the game at a virtual resolution
push = require 'push'

--	Global Variables
WINDOW_WIDTH = 1260
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

--	Game

--[[
	Runs when the game first runs, only once.
	The bootstrap of the game
]]
function love.load()
	
	--	
	math.randomseed(os.time())
	--	setting filter to point blank, to take out the blurry from virtualization
	love.graphics.setDefaultFilter('nearest', 'nearest')
	
	--	setting the base font of the game
	smallfont = love.graphics.newFont('font.ttf', 8)
	--	setting the font for the score
	scorefont = love.graphics.newFont('font.ttf', 32)
	
	--	setting the virtualization of the window, to make it look like old SNES
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
	
	--	setting up the score of both players
	player1score = 0
	player2score = 0

	--	setting the start position of each player
	player1Y = 20
	player2Y = VIRTUAL_HEIGHT - 40

	--	setting the start position of the ball
	ballX = VIRTUAL_WIDTH / 2 - 2
	ballY = VIRTUAL_HEIGHT / 2 - 2

	--	setting the speed of the ball
	ballDX = math.random(2) == 1 and -100 or 100
	ballDY = math.random(-50, 50)
	
	--	setting the game in 'start' mode
	gamestate = 'start'
end
--[[
	Runs every frame
	dt is for delta time
]]
function love.update(dt)

	--	uses the input of the user to update the vertical position of the player1
	if love.keyboard.isDown('w') then
		--	math.max set up the max range of the paddle so it wont get of the screen
		player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
	elseif love.keyboard.isDown('s') then
		--	math.min set up the min range of the paddle so it wont get of the screen
		player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
	end

	--	uses the input of the user to update the vertical position of the player2
	if love.keyboard.isDown('up') then
		--	math.max set up the max range of the paddle so it wont get of the screen
		player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
	elseif love.keyboard.isDown('down') then
		--	math.min set up the min range of the paddle so it wont get of the screen
		player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
	end

	-- moves the ball if the game starts
	if gamestate == 'play' then
		ballX = ballX + ballDX * dt
		ballY = ballY + ballDY * dt
	end
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
			gamestate = 'play'
		elseif gamestate == 'play' then
			gamestate = 'start'
			--	setting the start position of the ball
			ballX = VIRTUAL_WIDTH / 2 - 2
			ballY = VIRTUAL_HEIGHT / 2 - 2
			--	setting the speed of the ball
			ballDX = math.random(2) == 1 and -100 or 100
			ballDY = math.random(-50, 50)
		end
	end
end

--[[
	Called after update, used to draw anything in the screen
]]
function love.draw()

	--	push virtualization initialized
	push:apply('start')
	
	--	set up the base font of the game
	love.graphics.setFont(smallfont)

	--	draw the background in colour gray
	love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

	--	draw the ball
	love.graphics.rectangle('fill', ballX, ballY, 4, 4)
	
	--	draw the paddle 1
	love.graphics.rectangle('fill', 5, player1Y, 5, 20)

	--	draw the paddle 2
	love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

	--	print to screen
	if gamestate == 'start' then
		love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH,'center')
	elseif gamestate == 'play' then
		love.graphics.printf("Play Pong!", 0, 20, VIRTUAL_WIDTH,'center')
	end

	--	set up the score font and print the score
	love.graphics.setFont(scorefont)
	love.graphics.print(player1score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
	love.graphics.print(player2score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
	
	--	push virtualization must switch to end state
	 push:apply('end')
end