function init()
	-- Calc bound of the chunk so we can spawn items within it
    local chunkWorldXMin = chunk.X * chunk.Size
    local chunkWorldYMin = chunk.Y * chunk.Size
    local chunkWorldXMax = chunkWorldXMin + chunk.Size
    local chunkWorldYMax = chunkWorldYMin + chunk.Size

	-- Constants:
	-- Define item box region bounds (the area we want to spawn in)
    local regionXMin = -268
    local regionXMax = 305
    local regionYMin = -1029
    local regionYMax = -129

    local spacing = 75

  -- handle item spawning the first time a chunk is loaded
  if not chunk.Generated then
    -- Loop through each cell of the 100x100 grid
    for gridX = regionXMin, regionXMax, spacing do
      for gridY = regionYMin, regionYMax, spacing do
        -- Random offset within the current grid cell (0 to spacing-1)
        local x = gridX + math.random(0, spacing - 1)
        local y = gridY + math.random(0, spacing - 1)

        -- Only spawn box if the randomized position is in this chunk
        if x >= chunkWorldXMin and x < chunkWorldXMax and
           y >= chunkWorldYMin and y < chunkWorldYMax then
		   api.entity.Create("itembox", x, y, 50, {})
        end
      end
	end	
  end 

 
end
