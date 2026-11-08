-- KAITO HUB - MUSCLE LEGENDS (CRYSTAL FIX EDITION)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Anti-AFK
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Dynamic Remote Finder
local function getRemote(nameList)
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            for _, n in pairs(nameList) do
                if obj.Name:lower():find(n:lower()) then
                    return obj
                end
            end
        end
    end
    return nil
end

local punchRemote = getRemote({"punchEvent", "punch"})
local rebirthRemote = getRemote({"rebirthEvent", "rebirthRemote", "rebirth"})
local muscleRemote = getRemote({"repButtonPress", "muscleEvent", "muscle", "train", "addrep"})

-- CUSTOM KEY SYSTEM
local keyWindow = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local titleLabel = Instance.new("TextLabel")
local textBox = Instance.new("TextBox")
local submitBtn = Instance.new("TextButton")
local errorLabel = Instance.new("TextLabel")

keyWindow.Name = "KaitoKeySystem"
keyWindow.Parent = CoreGui
keyWindow.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

mainFrame.Name = "MainFrame"
mainFrame.Parent = keyWindow
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.Size = UDim2.new(0, 300, 0, 180)

titleLabel.Parent = mainFrame
titleLabel.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
titleLabel.Size = UDim2.new(0, 300, 0, 40)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "KAITO HUB | KEY SYSTEM"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18

textBox.Parent = mainFrame
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.Position = UDim2.new(0.1, 0, 0.35, 0)
textBox.Size = UDim2.new(0, 240, 0, 40)
textBox.Font = Enum.Font.SourceSans
textBox.PlaceholderText = "Enter Key here..."
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 16
textBox.ClearTextOnFocus = false

submitBtn.Parent = mainFrame
submitBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
submitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
submitBtn.Size = UDim2.new(0, 240, 0, 35)
submitBtn.Font = Enum.Font.SourceSansBold
submitBtn.Text = "SUBMIT KEY"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.TextSize = 16

errorLabel.Parent = mainFrame
errorLabel.BackgroundTransparency = 1
errorLabel.Position = UDim2.new(0.1, 0, 0.88, 0)
errorLabel.Size = UDim2.new(0, 240, 0, 15)
errorLabel.Font = Enum.Font.SourceSans
errorLabel.Text = ""
errorLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
errorLabel.TextSize = 14

local keyPassed = false

submitBtn.MouseButton1Click:Connect(function()
    if textBox.Text == "FREE2ALL" then
        keyPassed = true
        keyWindow:Destroy()
    else
        errorLabel.Text = "Maling key! Subukan ulit."
    end
end)

while not keyPassed do
    task.wait(0.5)
end

-- RAYFIELD WINDOW SETUP
local Window = Rayfield:CreateWindow({
    Name = "KAITO HUB | Muscle Legends",
    LoadingTitle = "Loading KAITO HUB...",
    LoadingSubtitle = "CREATED BY Kaito",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- NOTIFICATION
Rayfield:Notify({
    Title = "Access Granted!",
    Content = "Welcome to KAITO HUB, Bokbok!",
    Duration = 5
})

-- Global Variables
local autoWeight = false
local fastWeight1ms = false
local autoPushups, autoSitups = false, false
local autoClaimGift = false
local autoRebirth = false
local autoKill, autoKillEvil = false, false
local autoOpenCrystal = false
local selectedCrystal = "Blue Crystal"
local playerESP = false
local infJump = false

-- Attack Function
local function attackPlayer(targetPlayer)
    if not targetPlayer or targetPlayer == Player then return end
    local myChar = Player.Character
    local targetChar = targetPlayer.Character
    if myChar and targetChar then
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        local targetHum = targetChar:FindFirstChild("Humanoid")
        if myHRP and targetHRP and targetHum and targetHum.Health > 0 then
            local tool = Player.Backpack:FindFirstChild("Punch") or myChar:FindFirstChild("Punch")
            if tool and tool.Parent ~= myChar then tool.Parent = myChar end
            myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
            if tool then tool:Activate() end
            if punchRemote then
                punchRemote:FireServer("punch", "RightHand")
                punchRemote:FireServer("punch", "LeftHand")
            end
            pcall(function()
                firetouchinterest(myHRP, targetHRP, 0)
                firetouchinterest(myHRP, targetHRP, 1)
            end)
        end
    end
end

-- Infinite Jump Hook
UserInputService.JumpRequest:Connect(function()
    if infJump and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- TABS SETUP
local Tabs = {
    Home = Window:CreateTab("Home", "home"),
    Main = Window:CreateTab("Main Farm", "dumbbell"),
    Fast = Window:CreateTab("Fast Train (1ms)", "zap"),
    Pets = Window:CreateTab("Pets & Crystals", "egg"),
    PlayerMod = Window:CreateTab("Player Mod", "user"),
    Visuals = Window:CreateTab("Visuals", "eye"),
    Teleport = Window:CreateTab("Teleports", "map-pin"),
    Killer = Window:CreateTab("Killer", "user-x"),
    Rebirth = Window:CreateTab("Rebirths", "refresh-cw"),
    Settings = Window:CreateTab("Settings", "settings")
}

-- 1. HOME TAB
Tabs.Home:CreateParagraph({Title = "KAITO HUB MUSCLE LEGEND", Content = "CREATED BY Kaito\nVersion: Crystal Fixed Edition"})

-- 2. MAIN FARM TAB
Tabs.Main:CreateToggle({
    Name = "Auto Weight (Equip & Click)",
    CurrentValue = false,
    Callback = function(v)
        autoWeight = v
        task.spawn(function()
            while autoWeight do
                local t = Player.Backpack:FindFirstChild("Weight") or (Player.Character and Player.Character:FindFirstChild("Weight"))
                if t then
                    if t.Parent ~= Player.Character then t.Parent = Player.Character end
                    t:Activate()
                end
                task.wait(0.1)
            end
        end)
    end
})

Tabs.Main:CreateToggle({
    Name = "Auto Pushups",
    CurrentValue = false,
    Callback = function(v)
        autoPushups = v
        task.spawn(function()
            while autoPushups do
                local t = Player.Backpack:FindFirstChild("Pushups") or (Player.Character and Player.Character:FindFirstChild("Pushups"))
                if t then
                    if t.Parent ~= Player.Character then t.Parent = Player.Character end
                    t:Activate()
                end
                task.wait(0.1)
            end
        end)
    end
})

Tabs.Main:CreateToggle({
    Name = "Auto Situps",
    CurrentValue = false,
    Callback = function(v)
        autoSitups = v
        task.spawn(function()
            while autoSitups do
                local t = Player.Backpack:FindFirstChild("Situps") or (Player.Character and Player.Character:FindFirstChild("Situps"))
                if t then
                    if t.Parent ~= Player.Character then t.Parent = Player.Character end
                    t:Activate()
                end
                task.wait(0.1)
            end
        end)
    end
})

Tabs.Main:CreateToggle({
    Name = "Auto Claim All Gifts & Wheels",
    CurrentValue = false,
    Callback = function(v)
        autoClaimGift = v
        task.spawn(function()
            while autoClaimGift do
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("RemoteEvent") then
                        local n = obj.Name:lower()
                        if n:find("claim") or n:find("gift") or n:find("reward") or n:find("wheel") then
                            for i = 1, 12 do
                                pcall(function() obj:FireServer(i) end)
                                pcall(function() obj:FireServer(tostring(i)) end)
                            end
                        end
                    end
                end
                task.wait(1.5)
            end
        end)
    end
})

-- 3. FAST TRAIN TAB
Tabs.Fast:CreateToggle({
    Name = "Fast Weight (1ms)",
    CurrentValue = false,
    Callback = function(v)
        fastWeight1ms = v
        task.spawn(function()
            while fastWeight1ms do
                local t = Player.Backpack:FindFirstChild("Weight") or (Player.Character and Player.Character:FindFirstChild("Weight"))
                if t then
                    if t.Parent ~= Player.Character then t.Parent = Player.Character end
                    t:Activate()
                end
                if muscleRemote then
                    pcall(function()
                        muscleRemote:FireServer("repButtonPress")
                    end)
                end
                task.wait(0.001)
            end
        end)
    end
})

-- 4. PETS & CRYSTALS TAB (ULTRA FIXED)
Tabs.Pets:CreateDropdown({
    Name = "Select Crystal",
    Options = {"Blue Crystal", "Green Crystal", "Frost Crystal", "Mythical Crystal", "Infernal Crystal", "Legends Crystal", "Muscle King Crystal", "Galaxy Crystal", "Magma Crystal"},
    CurrentOption = "Blue Crystal",
    Callback = function(Option)
        selectedCrystal = Option[1] or Option
    end,
})

Tabs.Pets:CreateToggle({
    Name = "Auto Open Selected Crystal",
    CurrentValue = false,
    Callback = function(v)
        autoOpenCrystal = v
        task.spawn(function()
            while autoOpenCrystal do
                pcall(function()
                    -- Sinusubukan ang lahat ng posibleng remote na may kinalaman sa crystal o pets opening
                    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                            local name = obj.Name:lower()
                            if name:find("crystal") or name:find("open") or name:find("egg") then
                                pcall(function()
                                    if obj:IsA("RemoteFunction") then
                                        obj:InvokeServer(selectedCrystal, false)
                                        obj:InvokeServer(selectedCrystal)
                                    else
                                        obj:FireServer(selectedCrystal, false)
                                        obj:FireServer(selectedCrystal)
                                    end
                                end)
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end
})

Tabs.Pets:CreateButton({
    Name = "Equip Best Pets",
    Callback = function()
        pcall(function()
            for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                    local name = obj.Name:lower()
                    if name:find("pet") and (name:find("equip") or name:find("best")) then
                        pcall(function()
                            if obj:IsA("RemoteFunction") then obj:InvokeServer("equipBest") else obj:FireServer("equipBest") end
                        end)
                    end
                end
            end
        end)
    end
})

-- 5. PLAYER MOD TAB
Tabs.PlayerMod:CreateSlider({
    Name = "WalkSpeed Modifier",
    Range = {16, 300},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        pcall(function()
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = v
            end
        end)
    end
})

Tabs.PlayerMod:CreateSlider({
    Name = "JumpPower Modifier",
    Range = {50, 350},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v)
        pcall(function()
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.JumpPower = v
            end
        end)
    end
})

Tabs.PlayerMod:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v)
        infJump = v
    end
})

-- 6. VISUALS TAB
Tabs.Visuals:CreateToggle({
    Name = "Player Highlight ESP",
    CurrentValue = false,
    Callback = function(v)
        playerESP = v
        task.spawn(function()
            while playerESP do
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= Player and p.Character then
                        local char = p.Character
                        if not char:FindFirstChild("KaitoHighlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "KaitoHighlight"
                            hl.Adornee = char
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.Parent = char
                        end
                    end
                end
                task.wait(1)
            end
            if not playerESP then
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("KaitoHighlight") then
                        p.Character.KaitoHighlight:Destroy()
                    end
                end
            end
        end)
    end
})

-- 7. TELEPORT TAB
Tabs.Teleport:CreateButton({
    Name = "Normal Gym (Spawn)",
    Callback = function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 3, 0)
        end
    end
})

Tabs.Teleport:CreateButton({
    Name = "Frost Gym",
    Callback = function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(2583, 13, -1140)
        end
    end
})

Tabs.Teleport:CreateButton({
    Name = "Mythical Gym",
    Callback = function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(2457, 13, 852)
        end
    end
})

Tabs.Teleport:CreateButton({
    Name = "Eternal Gym",
    Callback = function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-6712, 13, -1256)
        end
    end
})

Tabs.Teleport:CreateButton({
    Name = "Legends Gym",
    Callback = function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(4171, 997, -3912)
        end
    end
})

Tabs.Teleport:CreateButton({
    Name = "Muscle King Gym",
    Callback = function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(8636, 17, -5945)
        end
    end
})

-- 8. KILLER TAB
Tabs.Killer:CreateToggle({
    Name = "Auto Kill All Players",
    CurrentValue = false,
    Callback = function(v)
        autoKill = v
        task.spawn(function()
            while autoKill do
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= Player then
                        attackPlayer(target)
                    end
                end
                task.wait(0.01)
            end
        end)
    end
})

Tabs.Killer:CreateToggle({
    Name = "Auto Kill Evil Karma",
    CurrentValue = false,
    Callback = function(v)
        autoKillEvil = v
        task.spawn(function()
            while autoKillEvil do
                for _, target in pairs(Players:GetPlayers()) do
                    if target ~= Player then
                        local karma = target:FindFirstChild("evilKarma") or (target:FindFirstChild("leaderstats") and target.leaderstats:FindFirstChild("Evil Karma"))
                        if karma and karma.Value > 0 then
                            attackPlayer(target)
                        end
                    end
                end
                task.wait(0.01)
            end
        end)
    end
})

-- 9. REBIRTH TAB
Tabs.Rebirth:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Callback = function(v)
        autoRebirth = v
        task.spawn(function()
            while autoRebirth do
                if rebirthRemote then
                    pcall(function() rebirthRemote:InvokeServer("rebirthRequest") end)
                    pcall(function() rebirthRemote:FireServer("rebirthRequest") end)
                end
                task.wait(0.2)
            end
        end)
    end
})

-- 10. SETTINGS TAB
Tabs.Settings:CreateButton({
    Name = "Anti-Lag / Low Graphics",
    Callback = function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
            end
        end
    end
})

Tabs.Settings:CreateButton({
    Name = "Server Hop (Palit ng Server)",
    Callback = function()
        pcall(function()
            local servers = {}
            local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            local body = HttpService:JSONDecode(req)
            for _, s in pairs(body.data) do
                if type(s) == "table" and s.maxPlayers > s.playing and s.id ~= game.JobId then
                    table.insert(servers, s.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Player)
            else
                Rayfield:Notify({Title = "Error", Content = "Walang mahanap na ibang server!", Duration = 3})
            end
        end)
    end
})

Tabs.Settings:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, Player)
    end
})
