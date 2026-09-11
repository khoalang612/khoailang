-- Roblox Kick Client
-- Player Removal/Kick System

local KickClient = {}
KickClient.__index = KickClient

-- Create a new KickClient instance
function KickClient.new()
	local self = setmetatable({}, KickClient)
	self.Players = game:GetService("Players")
	self.RemoteEvents = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents", 5)
	self.KickEvent = self.RemoteEvents:WaitForChild("KickPlayer", 5)
	
	return self
end

-- Kick a specific player by name
function KickClient:KickPlayerByName(playerName)
	local targetPlayer = self.Players:FindFirstChild(playerName)
	
	if targetPlayer then
		self:KickPlayer(targetPlayer)
		print("Kicked player: " .. playerName)
		return true
	else
		print("Player not found: " .. playerName)
		return false
	end
end

-- Kick a player object
function KickClient:KickPlayer(player)
	if player and player:IsA("Player") then
		-- Fire remote event to server
		pcall(function()
			self.KickEvent:FireServer(player)
		end)
		
		-- Local kick as backup
		player:Kick("You have been removed from the game!")
		print("Player kicked: " .. player.Name)
		return true
	end
	
	return false
end

-- Kick player by user ID
function KickClient:KickPlayerByUserId(userId)
	local targetPlayer = self.Players:FindFirstPlayerByUserId(userId)
	
	if targetPlayer then
		self:KickPlayer(targetPlayer)
		print("Kicked player with UserID: " .. userId)
		return true
	else
		print("Player with UserID not found: " .. userId)
		return false
	end
end

-- Kick all players (admin only)
function KickClient:KickAllPlayers()
	for _, player in pairs(self.Players:GetPlayers()) do
		if player ~= self.Players.LocalPlayer then
			self:KickPlayer(player)
		end
	end
	print("All players have been kicked!")
end

-- Listen for kick commands from server
function KickClient:ListenForKickCommands()
	local RemoteFunction = self.RemoteEvents:WaitForChild("OnKickCommand", 5)
	
	RemoteFunction.OnClientInvoke = function(player)
		print("Received kick command for: " .. player.Name)
		self:KickPlayer(player)
		return true
	end
end

-- Teleport player to void (alternative to kick)
function KickClient:TeleportToVoid(player)
	if player and player.Character then
		local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			humanoidRootPart.CFrame = CFrame.new(0, -500, 0) -- Teleport to void
			print("Player teleported to void: " .. player.Name)
			return true
		end
	end
	return false
end

return KickClient
