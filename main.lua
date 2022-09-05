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

--	Bootstrap of the game. Initializes the game
function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
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
	love.graphics.printf("Hello Pong!",				--	text to render
						 0,							--	starting "x"
						 WINDOW_HEIGHT / 2 - 6,		--	starting "y"
						 WINDOW_WIDTH,				--	number of pixels to center within
						 'center')					--	alignment 
end