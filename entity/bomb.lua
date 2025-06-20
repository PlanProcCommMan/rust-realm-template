local function init(self)
    -- Set how long the bomb lasts before despawning (in seconds)
	print("Created bomb with lifetime ",self.Data.lifetime)
	self.Data.lifetime = self.Data.lifetime or 1.0
	self.Data.timer = self.Data.lifetime
end

local function update(self, dt)
    self.Data.timer = self.Data.timer - dt
    if self.Data.timer <= 0 then
        print("Bomb despawned at", self:GetPosition())
        self:Remove()
    end
end

local function message(self, msg)
	if(msg.Data.messageType == "SpawnBomb") then
	  	local x, y, z = msg.Data.positionX, msg.Data.positionY, msg.Data.position
		self:MoveTo(x, y, z)
	end
	if(msg.Data.messageType == "BombCollided") then
		-- damage is handled in player, so all that is left is removing the bomb
		self:Remove()
	end
end

return {
    init = init,
    update = update,
    message = message
}
