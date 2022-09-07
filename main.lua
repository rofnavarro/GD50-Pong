--[[
	CS50 - GD50 - Pong Game

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


--	Game

--	bootstrap of the game, used to nitialize the game
function love.load()
	--	setting filter to point blank, to take out the blurry from virtualization
	love.graphics.setDefaultFilter('nearest', 'nearest')
	--	setting the virtualization of the window, to make it look like old SNES
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
end
--	function to verify if the 'esc' key os pressed to close the game
function love.keypressed(key)
	if key =='escape' then
		love.event.quit()
	end
end

--	function that deals with all the drawing 
function love.draw()
	--	push virtualization initialized
	push:apply('start')
	
	--	print to screen
	love.graphics.printf("Hello Pong!",				--	text to render
						 0,							--	starting "x"
						 VIRTUAL_HEIGHT / 2 - 6,	--	starting "y"
						 VIRTUAL_WIDTH,				--	number of pixels to center within
						 'center')					--	alignment 

	--	push virtualization must switch to end state
	 push:apply('end')
end