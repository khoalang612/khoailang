-- Kick Server Script
-- Server-side handler for kicking players

local KickServer = {}
KickServer.__index = KickServer

-- Create a new KickServer instance
function KickServer.new()
	local self = setmetatable({}, KickServer)
	self.Players = game:GetService("Players")
	self.ReplicatedStorage = game:GetService("ReplicatedStorage")
	
	-- Create RemoteEvents folder if it doesn't exist
	if not self.ReplicatedStorage:FindFirstChild("RemoteEvents") then
		local RemoteEventsFolder = Instance.new("Folder")
		RemoteEventsFolder.Name = "RemoteEvents"
		RemoteEventsFolder.Parent = self.ReplicatedStorage
	end
	
	self.RemoteEvents = self.ReplicatedStorage:WaitForChild("RemoteEvents")
	
	-- Create KickPlayer RemoteEvent if it doesn't exist
	if not self.RemoteEvents:FindFirstChild("KickPlayer") then
		local KickEvent = Instance.new("RemoteEvent")
		KickEvent.Name = "KickPlayer"
		KickEvent.Parent = self.RemoteEvents
	end
	
	self.KickEvent = self.RemoteEvents:WaitForChild("KickPlayer")
	
	return self
end

-- Kick a specific player by name
function KickServer:KickPlayerByName(playerName)
	local targetPlayer = self.Players:FindFirstChild(playerName)
	
	if targetPlayer then
		self:KickPlayer(targetPlayer)
		print("✅ Kicked player: " .. playerName)
		return true
	else
		print("❌ Player not found: " .. playerName)
		return false
	end
end

-- Kick a player object
function KickServer:KickPlayer(player)
	if player and player:IsA("Player") then
		player:Kick("You have been removed from the game!")
		print("✅ Player kicked: " .. player.Name)
		return true
	end
	
	return false
end

-- Kick player by user ID
function KickServer:KickPlayerByUserId(userId)
	local targetPlayer = self.Players:FindFirstPlayerByUserId(userId)
	
	if targetPlayer then
		self:KickPlayer(targetPlayer)
		print("✅ Kicked player with UserID: " .. userId)
		return true
	else
		print("❌ Player with UserID not found: " .. userId)
		return false
	end
end

-- Kick all players
function KickServer:KickAllPlayers()
	for _, player in pairs(self.Players:GetPlayers()) do
		self:KickPlayer(player)
	end
	print("✅ All players have been kicked!")
end

-- Teleport player to void
function KickServer:TeleportToVoid(player)
	if player and player.Character then
		local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			humanoidRootPart.CFrame = CFrame.new(0, -500, 0)
			print("✅ Player teleported to void: " .. player.Name)
			return true
		end
	end
	return false
end

-- Listen for player joins and set up event listeners
function KickServer:SetupPlayerListeners()
	self.Players.PlayerAdded:Connect(function(player)
		print("Player joined: " .. player.Name)
	end)
	
	self.Players.PlayerRemoving:Connect(function(player)
		print("Player left: " .. player.Name)
	end)
end

-- Listen for RemoteEvent calls
function KickServer:ListenForKickCommands()
	self.KickEvent.OnServerEvent:Connect(function(player, targetPlayer)
		if targetPlayer then
			self:KickPlayer(targetPlayer)
		end
	end)
end

-- Initialize server
local kickServer = KickServer.new()
kickServer:SetupPlayerListeners()
kickServer:ListenForKickCommands()

print("🚀 KickServer initialized!")

-- Export functions for direct use
return kickServer
