-- Loadstring Script for KickClient
-- Load KickClient directly from GitHub using HTTPS

local function LoadKickClient()
	-- GitHub raw content URL
	local url = "https://raw.githubusercontent.com/khoalang612/khoailang/main/KickClient.lua"
	
	-- Fetch the script content
	local success, result = pcall(function()
		return game:HttpGet(url)
	end)
	
	if success then
		-- Load and execute the script
		local KickClient = loadstring(result)()
		print("✅ KickClient loaded successfully!")
		return KickClient
	else
		warn("❌ Failed to load KickClient: " .. tostring(result))
		return nil
	end
end

-- One-liner loadstring (copy this to use)
-- local KickClient = loadstring(game:HttpGet("https://raw.githubusercontent.com/khoalang612/khoailang/main/KickClient.lua"))()

-- Usage example:
local KickClient = LoadKickClient()

if KickClient then
	local client = KickClient.new()
	print("KickClient is ready to use!")
	
	-- Example: Kick a player
	-- client:KickPlayerByName("PlayerName")
	
	-- Example: Teleport to void
	-- local player = game.Players:FindFirstChild("PlayerName")
	-- client:TeleportToVoid(player)
end
