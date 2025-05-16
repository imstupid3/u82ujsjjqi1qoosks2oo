local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local TpTool = Instance.new("Tool")
TpTool.Name = "Teleport Tool"
TpTool.RequiresHandle = false
TpTool.Parent = LocalPlayer.Backpack

local debounceCheck = false

TpTool.Activated:Connect(function()
	local Char = LocalPlayer.Character or workspace:FindFirstChild(LocalPlayer.Name)
	local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
	if not Char or not HRP then
		return warn("Failed to find HumanoidRootPart")
	end
	
	if not debounceCheck then
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://75415711"
		local bang = Char.Humanoid:LoadAnimation(anim)
		bang:Play()
		bang:AdjustSpeed(1)
		debounceCheck = true
		
		task.wait(1.5)
		local effectPart = Instance.new("Part")
		effectPart.Anchored = true
		effectPart.CanCollide = false
		effectPart.Transparency = 1
		effectPart.Size = Vector3.new(1, 1, 1)
		effectPart.CFrame = CFrame.new(HRP.Position)
		effectPart.Parent = workspace
	
		local ps = Instance.new("ParticleEmitter")
		ps.Texture = "rbxassetid://15268219678"
		ps.Color = ColorSequence.new(Color3.fromRGB(0, 170, 255))
		ps.LightEmission = 1
		ps.Size = NumberSequence.new(6)
		ps.Speed = NumberRange.new(0)
		ps.Lifetime = NumberRange.new(3)
		ps.Rate = 1
		ps.SpreadAngle = Vector2.new(360, 360)
		ps.Rotation = NumberRange.new(0, 360)
		ps.RotSpeed = NumberRange.new(30, 30)
		ps.Parent = effectPart
		ps:Emit(1)
			
		task.delay(1, function()
			HRP.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0), HRP.Position)
			ps:Emit(5)
			
			task.wait(1)
			ps.Enabled = false
			effectPart:Destroy()
			bang:Stop()
			debounceCheck = false
		end)
	else
		game:GetService("StarterGui"):SetCore("SendNotification", {
		    Title = "Markk made this lol!",
		    Text = "We've added boolean to detect dupe teleportation. Pls wait!",
		    Duration = 5
		})
	end
end)

pcall(function()
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Read lol.",
    Text = "Particle are visual",
    Duration = 5
})
end)
