Ball = Class{}

--	used to instantiate the object and set it own variables
function Ball:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	--	setting the speed of the ball
	self.dx = math.random(2) == 1 and -100 or 100
	self.dy = math.random(-50, 50)
end

--	used to rest the position of the ball to the middle
function Ball:reset()
	self.x = VIRTUAL_WIDTH / 2 - 2
	self.y = VIRTUAL_HEIGHT / 2 - 2
	
	--	setting the speed of the ball
	self.dx = math.random(2) == 1 and -100 or 100
	self.dy = math.random(-50, 50)
end

--	used to update the position of the pddle
function Ball:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
end

--	used to draw the object
function Ball:render()
	--	render the object updated
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
