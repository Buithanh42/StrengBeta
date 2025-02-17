print("LongHuyLoading")
wait(3)
print("LongHuyComplete")
local sitinklib = loadstring(game:HttpGet("https://github.com/ErutTheTeru/uilibrary/blob/main/Sitink%20Lib/Source.lua?raw=true"))()
local sitinkgui = sitinklib:Start({
    ["Name"] = "LH Hub | Streng",
    ["Description"] = "By Hvanlongg",
    ["Info Color"] = Color3.fromRGB(5.000000176951289, 59.00000028312206, 113.00000086426735),
    ["Logo Info"] = "",
    ["Logo Player"] = "",
    ["Name Info"] = "Havanlongg",
    ["Name Player"] = "havanlong_",
    ["Info Description"] = "",
    ["Tab Width"] = 135,
    ["Color"] = Color3.fromRGB(127.00000002980232, 146.00000649690628, 242.00000077486038),
    ["CloseCallBack"] = function() end
})
local MainTab = sitinkgui:MakeTab("Main")
local Section = MainTab:Section({
    ["Title"] = "cuttay",
    ["Content"] = "CacLonMM"
})
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local targetPosition = workspace.__MAP.World1.Trainings["1"].Zone.Position

local activeTween = nil -- Lưu tween hiện tại để dừng nếu cần

local function tweenPlayerToZone(player)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        
        -- Nếu đã có tween trước đó, dừng nó lại
        if activeTween then
            activeTween:Cancel()
        end

        local tweenInfo = TweenInfo.new(
            2, -- Thời gian tween (giây)
            Enum.EasingStyle.Quad, 
            Enum.EasingDirection.Out
        )
        
        local tweenGoal = {CFrame = CFrame.new(targetPosition)}
        activeTween = TweenService:Create(humanoidRootPart, tweenInfo, tweenGoal)
        activeTween:Play()
    end
end

-- Lấy người chơi hiện tại
local player = Players.LocalPlayer

-- Gán hàm vào sự kiện khi nhấn nút
local Button = Section:Button({
    ["Title"] = "Tele Trainings [1]",
    ["Content"] = "World1",
    ["Callback"] = function()
        print("Bay Veo Veo")
        tweenPlayerToZone(player) -- Gọi hàm khi nhấn nút
    end
})
local Dropdown = Section:Dropdown({
    ["Title"] = "Select Tools",
    ["Multi"] = false,  -- Chỉ cho phép chọn một mục
    ["Options"] = {"A", "B", "C"},
    ["Default"] = {"A"},
    ["Place Holder Text"] = "Select Tools",
    ["Callback"] = function(Value)
        print("Selected: " .. Value[1])  -- In giá trị đã chọn

        -- Tắt tất cả các code trước khi chạy cái mới
        -- Sử dụng logic để gửi sự kiện tương ứng với lựa chọn của người dùng
        if Value[1] == "A" then
            -- Gửi sự kiện "Punch"
            local args = {
                [1] = "S_Tools_Toggle",
                [2] = {"Punch"}
            }
            game:GetService("ReplicatedStorage").Common.Library.Network.RemoteEvent:FireServer(unpack(args))
        elseif Value[1] == "B" then
            -- Gửi sự kiện "Weight3"
            local args = {
                [1] = "S_Tools_Toggle",
                [2] = {"Weight3"}
            }
            game:GetService("ReplicatedStorage").Common.Library.Network.RemoteEvent:FireServer(unpack(args))
        elseif Value[1] == "C" then
            -- Gửi sự kiện "Ground Smash"
            local args = {
                [1] = "S_Tools_Toggle",
                [2] = {"Ground Smash"}
            }
            game:GetService("ReplicatedStorage").Common.Library.Network.RemoteEvent:FireServer(unpack(args))
        end
    end
})
local Toggle = Section:Toggle({
    ["Title"] = "Farm Train",
    ["Content"] = "Train",
    ["Default"] = false,
    ["Callback"] = function(Value)
        print(Value)
        if Value then
            -- Khi toggle bật, chạy liên tục
            while Value do
                -- Gọi InvokeServer
                local args = {
                    [1] = "S_Tools_Activate",
                    [2] = {}
                }
                game:GetService("ReplicatedStorage").Common.Library.Network.RemoteFunction:InvokeServer(unpack(args))
                
                wait(0.0000000001)  -- Tạm dừng 0.1 giây để tránh việc gọi liên tục quá nhanh
            end
        else
            -- Dừng khi toggle tắt
            print("Farm Train stopped.")
        end
    end
})
