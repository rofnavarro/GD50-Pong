Paddle = Class{}

--	used to instantiate the object and set it own variables
function Paddle:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.dy = 0
end

--	used to update the position of the pddle
function Paddle:update(dt)
	if self.dy < 0 then
		--	to not get off screen on botton
		self.y = math.max(0, self.y + self.dy * dt)
	else
		--	to not get off screen on bottom
		self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
	end
end

--	used to draw the object
function Paddle:render()
	--	render the object updated
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
