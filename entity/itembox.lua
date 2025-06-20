local RESPAWN_TIME = 20.0 -- seconds before respawn

local function init(self)
    self.Chunkloader = false
    self.Data.state = "active"
    self.Data.timer = 0
end

local function update(self, dt)
	-- update the timer and respawn the item box
    if self.Data.state == "respawning" then
        self.Data.timer = self.Data.timer - dt
        if self.Data.timer <= 0 then
            self.Data.state = "active"
            print("Item box respawned")
        end
    end
end

local function message(self, msg)
	if(msg.Data.messageType == "ItemBoxTaken") then
		self.Data.state = "respawning"
		self.Data.timer = RESPAWN_TIME
		print("Item box taken")
	end
end

return {init = init, update = update, message = message}
