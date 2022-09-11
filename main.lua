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
	
	--	setting the base font of the game
	smallfont = love.graphics.newFont('font.ttf', 8)

	--	setting the font to use
	love.graphics.setFont(smallfont)
	
	--	setting the virtualization of the window, to make it look like old SNES
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})
	
	--	creating the objects paddle for both players
	player1 = Paddle(5, 30, 5, 20)
	player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

	--	setting the start position of the ball
	ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

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
			gamestate = 'play'
		elseif gamestate == 'play' then
			gamestate = 'start'
			--	setting the start position of the ball
			ball:reset()
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

	--	print to screen
	if gamestate == 'start' then
		love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH,'center')
	else
		love.graphics.printf("Play Pong!", 0, 20, VIRTUAL_WIDTH,'center')
	end
	
	--	draw the paddles 
	player1:render()
	player2:render()
	
	--	draw the ball
	ball:render()
	
	--	push virtualization must switch to end state
	 push:apply('end')
end