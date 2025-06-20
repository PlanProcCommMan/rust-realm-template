-- init called on creation of entity
local function init(self)
    -- set player to a chunkloader, thous this is technically unnecessary as the game engine will force this regardless
    self.Chunkloader = true
end

-- update called each simulation step, with dt being the number of seconds since last step (float)
local function update(self, dt)
	--the player is driven by the client, so nothing needs to happen in update
end

-- called when this entity receives a message
-- as this is the player entity it can also receive messages from the game client
local function message(self, msg)
    -- if this is a client message (i.e. from a game client) then look in the message's Data table
	if msg.Client then
		if(msg.Data.messageType == "PlayerPosition") then
		  -- receive all info required to recreate players position
		  local x, y, z,rotationX,rotationY,rotationZ = msg.Data.x, msg.Data.y, msg.Data.z, msg.Data.rotationX , msg.Data.rotationY,msg.Data.rotationZ
		  self.Data.x = x
		  self.Data.y = y
		  self.Data.z = z
		  self.Data.rotationX = rotationX
		  self.Data.rotationY = rotationY
		  self.Data.rotationZ = rotationZ
		  self.Data.carType = msg.Data.carType
		  self.Data.health = msg.Data.health
		  self.Data.wheelData = msg.Data.wheelData
		  self:MoveTo(x, y, z)
		end
		
		-- if the player picks up an item, pass info on to the item entity
		if(msg.Data.messageType == "ItemBoxTaken") then
			api.entity.Message(msg.Data.receiverId, {message=msg, from=self.ID})
		end
		
		-- if the player spawns a bomb, create a new bomb entity
		if(msg.Data.messageType == "SpawnBomb") then
			local x, y, z = msg.Data.positionX, msg.Data.positionY, msg.Data.positionZ
			print("Bomb dropped by player at",x, z)
			local entity = api.entity.Create("bomb", x, y, z, {lifetime=20})
			-- send a message to the new bomb entity with the contents of the current message
			api.entity.Message(entity.ID, {message=msg, from=self.ID})
		end
		
		-- if a player collides with a bomb, pass the info on to the bomb entity
		if(msg.Data.messageType == "BombCollided") then
			self.Data.health = self.Data.health - 125
			api.entity.Message(msg.Data.receiverId, {message=msg, from=self.ID})
		end
    end
end

-- entity file must return table of this format
return { init = init, update = update, message = message }
