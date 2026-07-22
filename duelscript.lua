local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- Nettoyage de l'ancienne interface si elle existe
if pGui:FindFirstChild("SAB Exploit Script") then
    pGui.SAB Exploit Script:Destroy()
end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SAB Exploit Script"
screenGui.ResetOnSpawn = false
screenGui.Parent = pGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 160, 0, 260) -- Réduite en hauteur
mainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "⚡Steal a brainrot script"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 12
title.Font = Enum.Font.SourceSansBold
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title
local jumpPowerVal = 100
local walkSpeedVal = 16
local isNoclip = false
local tpClickActive = false

local speedConnection = nil
local noclipConnection = nil
local freezeConnection = nil
local frozenTarget = nil
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0.9, 0, 0, 24)
noclipBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
noclipBtn.Text = "Noclip : OFF"
noclipBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.Font = Enum.Font.SourceSansBold
noclipBtn.TextSize = 11
noclipBtn.Parent = mainFrame

local tpSafeBtn = Instance.new("TextButton")
tpSafeBtn.Size = UDim2.new(0.9, 0, 0, 24)
tpSafeBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
tpSafeBtn.Text = "Teleport"
tpSafeBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 40)
tpSafeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpSafeBtn.Font = Enum.Font.SourceSansBold
tpSafeBtn.TextSize = 10
tpSafeBtn.Parent = mainFrame

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0.9, 0, 0, 24)
speedBtn.Position = UDim2.new(0.05, 0, 0.38, 0)
speedBtn.Text = "Speed : Normal (16)"
speedBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 100)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.TextSize = 11
speedBtn.Parent = mainFrame

local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(0.9, 0, 0, 24)
jumpBtn.Position = UDim2.new(0.05, 0, 0.51, 0)
jumpBtn.Text = "Jump Power : 100"
jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBtn.Font = Enum.Font.SourceSansBold
jumpBtn.TextSize = 11
jumpBtn.Parent = mainFrame

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.9, 0, 0, 20)
resetBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
resetBtn.Text = "Reset Physiques"
resetBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
resetBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
resetBtn.Font = Enum.Font.SourceSans
resetBtn.TextSize = 10
resetBtn.Parent = mainFrame

local freezeBtn = Instance.new("TextButton")
freezeBtn.Size = UDim2.new(0.9, 0, 0, 24)
freezeBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
freezeBtn.Text = "freeze [player]"
freezeBtn.BackgroundColor3 = Color3.fromRGB(140, 50, 180)
freezeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeBtn.Font = Enum.Font.SourceSansBold
freezeBtn.TextSize = 11
freezeBtn.Parent = mainFrame
local function applyStats()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = jumpPowerVal
        
        if speedConnection then speedConnection:Disconnect() end
        speedConnection = RunService.Heartbeat:Connect(function()
            if humanoid and humanoid.Parent then
                humanoid.WalkSpeed = walkSpeedVal
            else
                if speedConnection then speedConnection:Disconnect() end
            end
        end)
    end
end
noclipBtn.MouseButton1Click:Connect(function()
    isNoclip = not isNoclip
    if isNoclip then
        noclipBtn.Text = "Noclip : ON"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        
        noclipConnection = RunService.Stepped:Connect(function()
            local char = player.Character
            if char and isNoclip then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                if noclipConnection then noclipConnection:Disconnect() end
            end
        end)
    else
        noclipBtn.Text = "Noclip : OFF"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        if noclipConnection then noclipConnection:Disconnect() end
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- --- LOGIQUE TP FLUIDE (Anti-Rubberband) ---
local function smoothTeleport(targetPosition)
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local startPos = root.Position
    local steps = 15

    for i = 1, steps do
        local alpha = i / steps
        local interpolatedPos = startPos:Lerp(targetPosition, alpha)
        root.CFrame = CFrame.new(interpolatedPos + Vector3.new(0, 3, 0))
        task.wait(0.01)
    end
end

tpSafeBtn.MouseButton1Click:Connect(function()
    tpClickActive = not tpClickActive
    if tpClickActive then
        tpSafeBtn.Text = "Clique n'importe où..."
        tpSafeBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    else
        tpSafeBtn.Text = "Teleport"
        tpSafeBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 40)
    end
end)

local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
    if tpClickActive then
        local targetPos = mouse.Hit.Position
        smoothTeleport(targetPos)
        tpClickActive = false
        tpSafeBtn.Text = "TP Fluide (Moins de Rubber)"
        tpSafeBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 40)
    end
end)
speedBtn.MouseButton1Click:Connect(function()
    if walkSpeedVal == 16 then walkSpeedVal = 32
    elseif walkSpeedVal == 32 then walkSpeedVal = 64
    elseif walkSpeedVal == 64 then walkSpeedVal = 100
    else walkSpeedVal = 16 end
    speedBtn.Text = "Speed : " .. tostring(walkSpeedVal)
    applyStats()
end)

jumpBtn.MouseButton1Click:Connect(function()
    if jumpPowerVal == 100 then jumpPowerVal = 200
    elseif jumpPowerVal == 200 then jumpPowerVal = 300
    else jumpPowerVal = 100 end
    jumpBtn.Text = "Jump Power : " .. tostring(jumpPowerVal)
    applyStats()
end)

resetBtn.MouseButton1Click:Connect(function()
    walkSpeedVal = 16
    jumpPowerVal = 50
    speedBtn.Text = "Speed : Normal (16)"
    jumpBtn.Text = "Jump Power : 50"
    applyStats()
end)

player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    applyStats()
end)

applyStats()
local function findPlayer(nameInput)
    if not nameInput or nameInput == "" then return nil end
    nameInput = string.lower(nameInput)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local name = string.lower(p.Name)
            local displayName = string.lower(p.DisplayName)
            if string.sub(name, 1, #nameInput) == nameInput or string.sub(displayName, 1, #nameInput) == nameInput then
                return p
            end
        end
    end
    return nil
end

local function toggleFreeze(targetPlayer)
    if frozenTarget == targetPlayer then
        if freezeConnection then freezeConnection:Disconnect() end
        frozenTarget = nil
        freezeBtn.Text = ";fr [Cible]"
    else
        if freezeConnection then freezeConnection:Disconnect() end
        frozenTarget = targetPlayer
        if frozenTarget then
            freezeBtn.Text = "Freezed: " .. string.sub(frozenTarget.Name, 1, 6)
            freezeConnection = RunService.RenderStepped:Connect(function()
                if not frozenTarget or not frozenTarget.Character then
                    if freezeConnection then freezeConnection:Disconnect() end
                    frozenTarget = nil
                    freezeBtn.Text = "Freeze [player]"
                    return
                end
                local targetRoot = frozenTarget.Character:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = frozenTarget.Character:FindFirstChildOfClass("Humanoid")
                if targetRoot then
                    targetRoot.AssemblyLinearVelocity = Vector3.zero
                    targetRoot.AssemblyAngularVelocity = Vector3.zero
                end
                if targetHumanoid then
                    targetHumanoid.PlatformStand = true
                end
            end)
        end
    end
end

player.Chatted:Connect(function(message)
    if string.sub(message, 1, 4) == ";fr " then
        local targetName = string.sub(message, 5)
        local found = findPlayer(targetName)
        if found then toggleFreeze(found) end
    end
end)

freezeBtn.MouseButton1Click:Connect(function()
    if frozenTarget then
        toggleFreeze(nil)
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player then
                toggleFreeze(p)
                break
            end
        end
    end
end)
