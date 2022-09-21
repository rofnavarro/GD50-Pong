Ai = Class{}

--	used to instantiate the object and set it own variables
function Ai:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.dy = 0
end

--	used to update the object based on other informations
function Ai:update(dt, dy)
	if dy < 0 then
		--	to not get off screen on botton
		self.y = math.max(0, self.y + self.dy * dt)
		if dy > VIRTUAL_HEIGHT / 2 then
			self.y = dy + 4
		elseif dy < VIRTUAL_HEIGHT / 2 then
			self.y = dy + 4
		end
	elseif dy > 0 then
		--	to not get off screen on bottom
		self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
		if dy > VIRTUAL_HEIGHT / 2 then
			self.y = dy + 4
		elseif dy < VIRTUAL_HEIGHT / 2 then
			self.y = dy + 4
		end
	end
end

function Ai:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end