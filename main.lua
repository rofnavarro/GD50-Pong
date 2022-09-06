--[[
	CS50 - GD50 - Pong Full Game

	Student: Rodrigo Ferrero

	Pong is originally made in 1972 and is considered
	the grandfather of games.

	This is a study of the implementation of the game 
	in lua programming language.
]]

--	Global Variables
WINDOW_WIDTH = 1260
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--	Requires
push = require 'push'

--	Bootstrap of the game. Initializes the game
function love.load()
	--	Setting filter to point blank
	love.graphics.setDefaultFilter('nearest', 'nearest')
	--	Setting the retro window
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
end

function love.keypressed(key)
	if key =='escape' then
		love.event.quit()
	end
end

--	Function that deals with all the drawing 
function love.draw()
	--	Push must be aplly, like a state machine 
	push:apply('start')
	
	love.graphics.printf("Hello Pong!",				--	text to render
						 0,							--	starting "x"
						 VIRTUAL_HEIGHT / 2 - 6,	--	starting "y"
						 VIRTUAL_WIDTH,				--	number of pixels to center within
						 'center')					--	alignment 

	--	Push must be apply at the end, like a change on a state machine
	 push:apply('end')
end