Ball = Class{}

--	used to instantiate the object and set it own variables
function Ball:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	--	setting the speed of the ball
	self.dy = math.random(2) == 1 and -150 or 150
	self.dx = math.random(-50, 50)
end

--	used to rest the position of the ball to the middle
function Ball:reset()
	self.x = VIRTUAL_WIDTH / 2 - 2
	self.y = VIRTUAL_HEIGHT / 2 - 2
	
	--	setting the speed of the ball
	self.dx = math.random(-75, 75)
end

--	used to verify if the ball collides with the paddles
function Ball:collide(box)
	--	if does not collides with the horizontal axis
	if self.x > box.x + box.width or box.x > self.x + self.width then
		return false
	end
	--	if does not collides with the vertical axis
	if self.y > box.y + box.height or box.y > self.y + self.height then
		return false
	end
	--	if collides
	return true
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
