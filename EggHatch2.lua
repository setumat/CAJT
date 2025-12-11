-- // CREATE GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ElegantAutoGUI"

-- Main Frame (smaller)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 190, 0, 165)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 14)

-- Shadow
local shadow = Instance.new("ImageLabel", frame)
shadow.ZIndex = -1
shadow.Position = UDim2.new(0, -18, 0, -18)
shadow.Size = UDim2.new(1, 36, 1, 36)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.45
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)

-- Gradient
local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 180))
})
gradient.Rotation = 45

-- Close Button
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 24, 0, 24)
close.Position = UDim2.new(1, -30, 0, 6)
close.Text = "x"
close.TextScaled = true
close.BackgroundColor3 = Color3.fromRGB(240, 60, 90)
close.TextColor3 = Color3.new(1,1,1)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -12, 0, 28)
title.Position = UDim2.new(0, 6, 0, 2)
title.Text = "Egg Hatch"
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold

-- Input 1
local box1 = Instance.new("TextBox", frame)
box1.Size = UDim2.new(0, 160, 0, 30)
box1.Position = UDim2.new(0, 15, 0, 40)
box1.Text = "7000076"
box1.PlaceholderText = "ID Egg"
box1.TextScaled = true
box1.Font = Enum.Font.Gotham
box1.BackgroundColor3 = Color3.fromRGB(255,255,255)
box1.BackgroundTransparency = 0.15
box1.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box1).CornerRadius = UDim.new(0, 8)

-- Input 2
local box2 = Instance.new("TextBox", frame)
box2.Size = UDim2.new(0, 160, 0, 30)
box2.Position = UDim2.new(0, 15, 0, 80)
box2.Text = "0.5"
box2.PlaceholderText = "Delay"
box2.TextScaled = true
box2.Font = Enum.Font.Gotham
box2.BackgroundColor3 = Color3.fromRGB(255,255,255)
box2.BackgroundTransparency = 0.15
box2.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box2).CornerRadius = UDim.new(0, 8)

-- Input 3
local box3 = Instance.new("TextBox", frame)
box2.Size = UDim2.new(0, 160, 0, 30)
box2.Position = UDim2.new(0, 15, 0, 80)
box2.Text = "10"
box2.PlaceholderText = "Qty"
box2.TextScaled = true
box2.Font = Enum.Font.Gotham
box2.BackgroundColor3 = Color3.fromRGB(255,255,255)
box2.BackgroundTransparency = 0.15
box2.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box2).CornerRadius = UDim.new(0, 8)

-- Toggle Button
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0, 160, 0, 35)
toggle.Position = UDim2.new(0, 15, 0, 120)
toggle.Text = "START"
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBold
toggle.BackgroundColor3 = Color3.fromRGB(255,255,255)
toggle.BackgroundTransparency = 0.1
toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

local glow = Instance.new("UIGradient", toggle)
glow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 240)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 110, 255))
})
glow.Rotation = 90

-- Status Label
local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(0, 130, 0, 22)
status.Position = UDim2.new(0.5, -65, -0.23, 0)
status.Text = "OFF"
status.TextScaled = true
status.BackgroundColor3 = Color3.fromRGB(150, 0, 60)
status.TextColor3 = Color3.new(1,1,1)
status.Font = Enum.Font.GothamBold
Instance.new("UICorner", status).CornerRadius = UDim.new(0, 8)

-- // Logic
local running = false
local working = false

local function doTask(id)
    local args = {id, qty}
    game:GetService("ReplicatedStorage")
        :WaitForChild("Tool")
        :WaitForChild("DrawUp")
        :WaitForChild("Msg")
        :WaitForChild("DrawHero")
        :InvokeServer(unpack(args))
end

-- Toggle button
toggle.MouseButton1Click:Connect(function()
    running = not running

    if running then
        toggle.Text = "STOP"
        status.Text = "ON"
        status.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
    else
        toggle.Text = "START"
        status.Text = "OFF"
        status.BackgroundColor3 = Color3.fromRGB(150, 0, 60)
    end

    if running and not working then
        working = true
        task.spawn(function()
            while running do
                local id = tonumber(box1.Text) or 7000076
                local delay = tonumber(box2.Text) or 0.5
                local qty = tonumber(box3.Text) or 10
                doTask(id)
                task.wait(delay)
            end
            working = false
        end)
    end
end)

-- Close GUI (stop loop first)
close.MouseButton1Click:Connect(function()
    running = false      -- hentikan loop
    working = false      -- pastikan tidak ada loop aktif
    gui:Destroy()        -- baru tutup GUI
end)
