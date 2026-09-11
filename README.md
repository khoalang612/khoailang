# Roblox Kick Client 🎮

Một Lua client module cho Roblox để kick/loại bỏ player khỏi game.

## 📋 Tính năng

- ✅ Kick player theo tên
- ✅ Kick player theo User ID
- ✅ Kick tất cả players
- ✅ Teleport player đến void (thế giới khác)
- ✅ Lắng nghe lệnh kick từ server
- ✅ Hỗ trợ Remote Events

## 🚀 Cách sử dụng

### 1. Import module

```lua
local KickClient = require(game.ReplicatedStorage:WaitForChild("KickClient"))
local client = KickClient.new()
```

### 2. Kick player theo tên

```lua
client:KickPlayerByName("PlayerName")
```

### 3. Kick player theo User ID

```lua
client:KickPlayerByUserId(12345678)
```

### 4. Kick player object

```lua
local player = game.Players:FindFirstChild("PlayerName")
client:KickPlayer(player)
```

### 5. Kick tất cả players

```lua
client:KickAllPlayers()
```

### 6. Teleport player đến void

```lua
client:TeleportToVoid(player)
```

### 7. Lắng nghe lệnh kick từ server

```lua
client:ListenForKickCommands()
```

## 📁 Cấu trúc thư mục

```
khoailang/
├── KickClient.lua      # Main client module
├── README.md           # Hướng dẫn này
└── Server/
    └── KickServer.lua  # Server-side handler (tùy chọn)
```

## ⚙️ Yêu cầu

- Roblox Studio
- Lua enabled
- ReplicatedStorage folder với RemoteEvents

## 📝 Ví dụ đầy đủ

```lua
local KickClient = require(game.ReplicatedStorage:WaitForChild("KickClient"))
local client = KickClient.new()

-- Kick một player cụ thể
client:KickPlayerByName("Hacker123")

-- Hoặc theo ID
client:KickPlayerByUserId(123456789)

-- Hoặc teleport họ đến void
local player = game.Players:FindFirstChild("BadPlayer")
if player then
    client:TeleportToVoid(player)
    wait(1)
    client:KickPlayer(player)
end
```

## 🔒 Lưu ý bảo mật

- Chỉ sử dụng trên server-side để tránh exploit
- Kiểm tra quyền admin trước khi kick
- Không để player local có thể kick ai đó tùy ý

## 📞 Hỗ trợ

Nếu có vấn đề, hãy tạo Issue trên GitHub! 😊

---

**Made with ❤️ by khoalang612**
