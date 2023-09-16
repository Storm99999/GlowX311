--[[
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    x                                   GlowX311                                        x
    x                                                                                   x
    x                The way we approach visual aesthetics in digital environments.     x
    x                   Made with <3 by _newguy._15179 and hashions                     x
    x                                                                                   x
    x                                                                                   x
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

]]

local glow = {};
glow.__savedinstances = game:GetObjects("rbxassetid://14790882035")[1]
glow.__connections = {}
glow.__index = glow;

local highlightFolder = Instance.new('Folder', game:GetService('CoreGui'))
highlightFolder.Name = 'GlowStorage'

local function getAliveStateOf(x)
    if x.Character and x.Character:FindFirstChildOfClass'Humanoid' then
        if x.Character.Humanoid.Health > 0 and x.Character:FindFirstChild'HumanoidRootPart' then
            return true;
        end
    end
end

function glow:CreatePointer(player, configuration)
    local use_highlight = configuration['Highlight'] or false
    local highlight_color = configuration['Highlight_Color'] or Color3.new()
    local image_gradient_color = configuration['Gradient_Instance'] or nil
    local glow_color = configuration['Glow_Color'] or Color3.new()
    if (highlightFolder:FindFirstChild(player.Name)) then return warn("[GlowX311] Player already rendered") end
    
    local target_folder = Instance.new('Folder', highlightFolder)
    target_folder.Name = player.Name

    local bodyparts_essential = {'Head','RightUpperArm','LeftUpperArm','UpperTorso','RightUpperLeg','LeftUpperLeg'}

    local function addInstances()
        if (getAliveStateOf(player))  then
            for _,v in next, player.Character:GetChildren() do
                if (table.find(bodyparts_essential, v.Name)) then
                    for i, x in next, glow.__savedinstances do
                        if (x.Name == v.Name) then
                            for ind, lol in next, x:GetChildren() do
                                local final = lol:Clone()
                                final:FindFirstChildOfClass('ImageLabel').ImageColor3 = glow_color
                                if image_gradient_color ~= nil then image_gradient_color:Clone().Parent = final end
                            end
                        end
                    end
                end
            end
        end
    end

    table.insert(glow.__connections, player.CharacterAdded:Connect(function()
        -- reconnect the glow
        addInstances()
        if (use_highlight and highlightFolder:FindFirstChild(player.Name)) then
            highlightFolder[player.Name]:ClearAllChildren()
            local highlight_instance = Instance.new('Highlight', highlightFolder[player.Name])
            highlight_instance.Adornee = player.Character
            highlight_instance.FillTransparency = 0.45
            highlight_instance.OutlineTransparency = 1
            highlight_instance.FillColor = highlight_color
        else
            return warn("[GlowX311] Player does not have a valid Highlight Folder")
        end
    end))
end

function glow:DisconnectPointers()
    for _, v in next, glow.__connections do
        v:Disconnect()
    end

    task.spawn(function()
        for _,v in next, game:GetDescendants() do
            if (v.Name = "GlowX311") then
                v:Remove()
            end
        end

        highlightFolder:ClearAllChildren()
    end)
end

return glow
