--[[
	CS50 - GD50 - Pong Full Game

	Author: Colton Ogden
	cogden@cs50.harvard.edu

	Student: Rodrigo Ferrero

	Pong is originally made in 1972 and is considered
	the grandfather of games.

	This is a study of the implementation of the game 
	in lua programming language.
]]

--	Global Variables
WINDOW_WIDTH = 1260
WINDOW_HEIGHT = 720

--	Bootstrap of the game
function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
end

--	Function that deals with all the drawing 
function love.draw()
	love.graphics.printf("Hello Pong!", 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, 'center')
end