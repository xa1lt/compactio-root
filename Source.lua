-- // -> VARIABLES <- \\ ---
local TweenService = game:GetService'TweenService'
local UIS = game:GetService'UserInputService'
local CoreGui = game:GetService'CoreGui'
local Mouse = game:GetService'Players'.LocalPlayer:GetMouse()
local Compactio = {}
local Functions = {}
local Debug = {}
-- // -> FUNCTIONS <- \\ ---
function Shadow(instance: Instance, color: Color3Value)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Parent = instance
    Shadow.ImageColor3 = color
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23,23,277,277)
    Shadow.Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30)
    Shadow.Position = UDim2.fromOffset(-15,-15)
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.BackgroundTransparency = 1 
    return Shadow
end
function Corner(instance: Instance, radius: UDim)
    local Corner = Instance.new("UICorner")
    Corner.Parent = instance
    Corner.CornerRadius = radius
end
function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end
function Align(instance: Instance)
    local Padding = Instance.new("UIPadding")
    Padding.Parent = instance
    Padding.PaddingLeft = UDim.new(0,6)
end
function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Instance.new("ImageLabel")
    Circle.Image = "http://www.roblox.com/asset/?id=5554831670"
    Circle.BackgroundTransparency = 1 
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(1), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(2)
		Circle:Destroy()
	end)
end
-- // -> Saving <- \\ ---
_G.Saving = 
{
    Position = nil
}
function toTable(value: UDim2)
    return {value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset}
end
function fromTable(value: UDim2)
    return UDim2.new(value[1], value[2], value[3], value[4])
end
function Check()
    if writefile or appendfile or readfile or isfile or makefolder or delfolder or isfolder then
        return true
    else
        return false
    end
end
if Check() then
    makefolder("./Compactio/")
end
local folder = "./Compactio/settings.dat"
function load()
    if (Check() and isfile(folder)) then
        _G.Saving = game:GetService("HttpService"):JSONDecode(readfile(folder))
    end
end
function save()
    local json
    if Check() then
        json = game:GetService("HttpService"):JSONEncode(_G.Saving)
        writefile(folder, json)
    else
        print("Not supported")
    end
end
 function AddDraggingFunctionality(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false
		DragPoint.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		DragPoint.InputChanged:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement then
				DragInput = Input
			end
		end)
		UIS.InputChanged:Connect(function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				TweenService:Create(Main, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
			end
		end)
	end)
end   

load()
save()
-- // -> MISC <- \\ ---
local Elements = 
{
    "button",
    "keybind",
    "colorpicker",
    "dropdown",
    "toggle",
    "slider",
    "dataset",
    "label",
    "textfield"
}
local Themes = 
{
    Dark = 
    {
        DefaultBackground = Color3.fromRGB(22,22,22),
        DefaultShadow = Color3.fromRGB(0,0,0),
        Header = Color3.fromRGB(34,34,34),
        TabActive = Color3.fromRGB(230,230,230),
        TabUnactive = Color3.fromRGB(150,150,150),
        Section_Back = Color3.fromRGB(30,30,30),
        Elements_Shadow = Color3.fromRGB(15,15,15),
        Elements_Back = Color3.fromRGB(42,42,42),
        Elements_TextColor = Color3.fromRGB(215,215,215),
        Elements_StrokeColor = Color3.fromRGB(65,65,65),
        Elements_Overlay = Color3.fromRGB(55,55,55),
        Accent = Color3.fromRGB(215, 215, 215)
    }
}
function Stroke(instance: Instance, color)
    local stroke = Instance.new("UIStroke")
    color = color or Themes.Dark.Elements_StrokeColor
                    stroke.Parent = instance
                    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    stroke.LineJoinMode = Enum.LineJoinMode.Round
                    stroke.Color = color
                    stroke.LineJoinMode = Enum.LineJoinMode.Round
                    stroke.Thickness = 1
                    stroke.Transparency = 1 
    return stroke
end
function Compactio.Destroy()
    for i,v in next, game.CoreGui:GetChildren() do
        if v:IsA("ScreenGui") and v.Name == "Base" then
            v:Destroy()
        end
    end
end
function Compactio.Toggle()
    CoreGui:FindFirstChild("Base").Enabled = not CoreGui:FindFirstChild("Base").Enabled
end
Compactio.Destroy()
-- // -> SCRIPTING <- \\ ---
function Compactio.Render(settings)
        -- // -> VARIABLES <- \\ -- 
    settings = settings or {}
    local options = settings.Options or {}
    local title = settings.Title or "Compactio"
    local savePosition = settings.Save or false
    local X = options.SizeX or 400
    local Y = options.SizeY or 500
        -- // -> GUI INSTANCES <- \\ -- 
    local base = Instance.new("ScreenGui")
    local motherFrame = Instance.new("Frame")
    local header = Instance.new("Frame")
    local flag = Instance.new("TextLabel")
    local headerCover = Instance.new("Frame")
    local tabContainer = Instance.new("ScrollingFrame")
    local tabList = Instance.new("UIListLayout")
    local tabPadding = Instance.new("UIPadding")
    local pages = Instance.new("Folder")
        -- // -> PROPS <- \\ -- 
    --#region BASE
    base.Parent = CoreGui
    base.Name = "Base"
    --#region MOTHERFRAME
    motherFrame.Parent = base
    motherFrame.BackgroundColor3 = Themes.Dark.DefaultBackground
    motherFrame.AnchorPoint = Vector2.new(.5,.5)
    motherFrame.Position = UDim2.new(0.5,0,.5,0)
    motherFrame.Size = UDim2.fromOffset(X,Y)
    Corner(motherFrame,UDim.new(0,5))
    Shadow(motherFrame,Themes.Dark.DefaultShadow)
    --#region HEADER
    header.Parent = motherFrame
    header.BackgroundColor3 = Themes.Dark.Header
    header.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,24)
    Corner(header,UDim.new(0,5))
    Shadow(header,Themes.Dark.Header)
    AddDraggingFunctionality(motherFrame,motherFrame)
    --#region FLAG
    flag.Parent = header
    flag.Size = UDim2.fromScale(1,1)
    flag.BackgroundTransparency = 1
    flag.Font = Enum.Font.Gotham
    flag.TextSize = 12 
    flag.TextColor3 = Themes.Dark.TabActive
    flag.Text = title
    flag.RichText = true 
    --#region HEADER_COVER
    headerCover.Parent = header
    headerCover.BackgroundColor3 = Themes.Dark.Header
    headerCover.BorderSizePixel = 0 
    headerCover.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,6)
    headerCover.Position = UDim2.fromScale(0,1) - UDim2.fromOffset(0, 3)
    --#region TAB_CONTAINER
    tabContainer.Parent = motherFrame
    tabContainer.BackgroundColor3 = Themes.Dark.Header
    tabContainer.ScrollBarImageTransparency = 1
    tabContainer.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,34)
    tabContainer.Position = UDim2.fromOffset(0,27)
    tabContainer.BorderSizePixel = 0 
    tabContainer.CanvasSize = UDim2.fromScale(0,0) + UDim2.fromOffset(0,0)
    --#region TAB_LIST
    tabList.Parent = tabContainer
    tabList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.FillDirection = Enum.FillDirection.Horizontal
    tabList.Padding = UDim.new(0,14)
    --#region TAB_PADDING
    tabPadding.Parent = tabContainer
    tabPadding.PaddingLeft = UDim.new(0, 11)
    --#region PAGE
    pages.Parent = motherFrame
    --#region NEW REGION
    local Create = {}
    function Create.Tab(settings)
                local Title = settings.Title or "New Tab"
                -- // -> GUI INSTANCES <- \\ -- 
                local tab = Instance.new("TextButton")
                local page = Instance.new("ScrollingFrame")
                local pageList = Instance.new("UIListLayout")
                local pagePadding = Instance.new("UIPadding")
                local tabIndex = 0 
                local pageIndex = 0
                local info = TweenInfo.new(.25)
                -- // -> PROPS <- \\ -- 
                --#region TAB
                tab.Name = "Tab"
                tab.Parent = tabContainer
                tab.BackgroundTransparency  = 1
                tab.TextColor3 = Themes.Dark.TabActive
                tab.Size = UDim2.fromScale(0,1)
                tab.Text = Title
                tab.TextSize = 12
                tab.Font = Enum.Font.GothamBold
                tab.AutomaticSize = Enum.AutomaticSize.X
                --#region PAGE
                page.Parent = pages
                page.BackgroundTransparency = 1
                page.ScrollBarImageTransparency = 1 
                page.Position = UDim2.fromOffset(0,54)
                page.Size = UDim2.fromScale(1,1) - UDim2.fromOffset(0,55)
                page.BorderSizePixel = 0
                page.CanvasSize = UDim2.fromScale(0,0)
                --#region PAGE_LIST 
                pageList.Parent = page 
                pageList.FillDirection =Enum.FillDirection.Vertical
                pageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
                pageList.Padding = UDim.new(0,7)
                task.spawn(function()
                    while task.wait() do
                        page.CanvasSize = UDim2.fromOffset(0,pageList.AbsoluteContentSize.Y + 18)
                    end
                end)
                --#region PAGE_PADDING
                pagePadding.Parent = page
                pagePadding.PaddingTop = UDim.new(0,14)

                --#region TAB & PAGE SCRIPTING
                for i,v in pairs (tabContainer:GetChildren()) do
                    if v:IsA("TextButton") then
                        tabIndex = tabIndex + 1 
                        v.Name = "Tab_" .. tostring(tabIndex)
                    end
                    if v:IsA("TextButton") and v.Name ~= "Tab_1" then
                        v.TextColor3 = Themes.Dark.TabUnactive
                        v.TextSize = 10
                    end
                end
                for i,v in pairs (pages:GetChildren()) do
                    pageIndex = pageIndex + 1 
                    v.Name = "Page_" .. tostring(pageIndex)
                    if v.Name ~= "Page_1" then
                        v.Visible = false
                    end
                end

                local function tabClicked()
                    for i,v in pairs (tabContainer:GetChildren()) do
                        if v:IsA("TextButton") then
                            local goal = {}
                            goal.TextColor3 = Themes.Dark.TabUnactive
                            goal.TextSize = 10 
                            TweenService:Create(v,TweenInfo.new(.1),goal):Play()
                        end
                    end
                    local goal2 = {}
                    goal2.TextColor3 = Themes.Dark.TabActive
                    goal2.TextSize = 12 
                    TweenService:Create(tab,TweenInfo.new(.1),goal2):Play()
                    for i,v in pairs (pages:GetChildren()) do
                        v.Visible = false
                    end
                    page.Visible = true
                end
                tab.MouseButton1Click:Connect(tabClicked)
                -- // ! END TABS ! \\ -- 
                local Create2 = {}
                function Create2.Section(settings)
                    local Title = settings.Title or "New Section"
                  
                    local sectionFrame = Instance.new("Frame")
                    local sectionTitle = Instance.new("TextLabel")
                    local sectionList = Instance.new("UIListLayout")
                    local sectionBorder = Instance.new("Frame")

                    sectionFrame.Parent = page
                    sectionFrame.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-25,45)
                    sectionFrame.BackgroundColor3 = Themes.Dark.Section_Back
                    Corner(sectionFrame,UDim.new(0,4))
                    sectionTitle.Parent = sectionFrame
                    sectionTitle.TextSize = 14 
                    sectionTitle.TextColor3 = Themes.Dark.Elements_TextColor
                    sectionTitle.BackgroundTransparency = 1
                    sectionTitle.Font = Enum.Font.GothamMedium
                    sectionTitle.TextXAlignment = Enum.TextXAlignment.Center
                    sectionTitle.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,25)
                    sectionTitle.Text = Title
                    
                    sectionBorder.Parent = sectionTitle
                    sectionBorder.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,1)
                    sectionBorder.Position = UDim2.fromScale(0,1)
                    sectionBorder.BorderSizePixel = 0 
                    sectionBorder.BackgroundColor3 = Themes.Dark.Elements_StrokeColor
                    
                    sectionList.Parent = sectionFrame
                    sectionList.Padding = UDim.new(0,6)
                    sectionList.SortOrder = Enum.SortOrder.LayoutOrder
                    sectionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    task.spawn(function()
                        while task.wait() do
                            sectionFrame.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-25,sectionList.AbsoluteContentSize.Y + 21)
                        end
                    end)
                    local E = {}

                    function E.new(settings)
                        local toMake = string.lower(settings.Type) or "button"
        if table.find(Elements,toMake) then
            if (toMake == "button") then 
            local Title = settings.Title or "New Button"
            local Callback = settings.Callback or function() warn("You forgot a callback!") end 
            local buttonFunctions = {}
            local buttonHolder = Instance.new("Frame")
            local button  = Instance.new("TextButton")
            local stroke = Stroke(buttonHolder)
            buttonHolder.Parent = sectionFrame
            buttonHolder.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)
            buttonHolder.BackgroundColor3 = Themes.Dark.Elements_Back
            buttonHolder.ClipsDescendants = true
            Shadow(buttonHolder,Themes.Dark.Elements_Back)
            Corner(buttonHolder,UDim.new(0,4))
            button.Parent = buttonHolder
            button.BackgroundTransparency = 1 
            button.AutoButtonColor = false 
            button.Size = UDim2.fromScale(1,1)
            button.Text = Title
            button.TextSize = 12
            button.Font = Enum.Font.Gotham
            button.RichText = true 
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.TextColor3 = Themes.Dark.Elements_TextColor
            Align(button)
          
            local function onEnter()
                    TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
            end
            local function onLeave()
                TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
            end
            local function onClick()
                pcall(function()
                    Callback()
                end)
                CircleAnim(buttonHolder,Themes.Dark.Elements_StrokeColor,Themes.Dark.Elements_Back)
            end
            button.MouseEnter:Connect(onEnter)
            button.MouseLeave:Connect(onLeave)
            button.MouseButton1Click:Connect(onClick)

            function buttonFunctions:SetText(newText)
                button.Text = newText
            end
            return buttonFunctions
        elseif (toMake == "label") then
            local Title = settings.Title or "New Label"
            local labelFunctions = {}
           
            local label = Instance.new("TextLabel")
            label.Parent = sectionFrame
            label.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)
            label.BackgroundColor3 = Themes.Dark.Elements_Back
            label.Text = Title
            label.TextSize = 15
            label.Font = Enum.Font.Gotham
            label.RichText = true 
            label.TextXAlignment = Enum.TextXAlignment.Center
            label.TextColor3 = Themes.Dark.Elements_TextColor
            Shadow(label,Themes.Dark.Elements_Back)
            Corner(label,UDim.new(0,4))

            function labelFunctions:SetText(newText)
                label.Text = newText
            end
            return labelFunctions
        elseif (toMake == "slider") then
                  -- \\ -> VARIABLES <- // --
            local Title = settings.Title or "New Slider"
            local Minimum = settings.Min or 0
            local Max = settings.Max or 1
            local Default = settings.Default or Minimum
            local Callback = settings.Callback or function() warn("You forgot a callback!") end 
            local sliderFunctions = {}
            local sliderFrame = Instance.new("Frame")
            local sliderTitle = Instance.new("TextLabel")
            local sliderInt = Instance.new("TextBox")
            local sliderButton = Instance.new("TextButton")
            local sliderInner = Instance.new("Frame")
            local stroke = Stroke(sliderFrame)

            if Minimum > Max then
                local vb = Minimum
                Minimum, Max = Max, vb
               end
               local SliderDef = math.clamp(Default, Minimum, Max) or math.clamp(50, Minimum, Max)
               local DefaultScale =  (Default - Minimum) / (Max - Minimum)

               
			local MinSize = 10
			local MaxSize = 36
        -- \\ -> PROPS <- // --

            sliderFrame.Parent = sectionFrame
            sliderFrame.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,55)
            sliderFrame.BackgroundColor3 = Themes.Dark.Elements_Back
            Shadow(sliderFrame,Themes.Dark.Elements_Back)
            Corner(sliderFrame,UDim.new(0,4))
            sliderTitle.Parent = sliderFrame
            sliderTitle.Size = UDim2.fromScale(1,1) + UDim2.fromOffset(0,-31)
            sliderTitle.Position = UDim2.fromOffset(0,6)
            sliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            sliderTitle.BackgroundTransparency = 1 
            sliderTitle.TextColor3 = Themes.Dark.Elements_TextColor
            sliderTitle.Font = Enum.Font.Gotham
            sliderTitle.Text = Title
            sliderTitle.TextSize = 12
            Align(sliderTitle)
            sliderInt.Parent = sliderFrame
            sliderInt.Size = UDim2.fromScale(0,1) + UDim2.fromOffset(100,-31)
            sliderInt.Position =  UDim2.fromScale(1,0) + UDim2.fromOffset(-111,6)
            sliderInt.TextXAlignment = Enum.TextXAlignment.Right
            sliderInt.BackgroundTransparency = 1 
            sliderInt.TextColor3 = Themes.Dark.Elements_TextColor
            sliderInt.Font = Enum.Font.Gotham
            sliderInt.Text = Default
            sliderInt.TextSize = 12
            sliderButton.Parent = sliderFrame
            sliderButton.BackgroundColor3 = Themes.Dark.Elements_Overlay
            sliderButton.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,9)
            sliderButton.Position = UDim2.fromScale(0.5,1) - UDim2.fromOffset(0,15)
            sliderButton.Text = ""
            sliderButton.AutoButtonColor = false
            sliderInner.Parent = sliderButton
            sliderInner.Size = UDim2.fromScale(DefaultScale,1)
            sliderInner.BackgroundColor3 = Themes.Dark.Accent
            sliderInner.BorderColor3 = Color3.fromRGB(42,42,42)
            Corner(sliderInner,UDim.new(0,7))
            Corner(sliderButton,UDim.new(0,7))
            sliderButton.AnchorPoint = Vector2.new(.5,.5)        
            pcall(function()
                Callback(sliderInt.Text)
            end)

            sliderInt.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                if enterPressed then
                       numb = tonumber(sliderInt.Text)
                 
                      local function check()
                            if numb < Minimum and numb > Max then
                                return false 
                                elseif numb >= Minimum and numb <= Max then
                                    return true 
                                end
                      end
                      if check() then
                        local oldSliderDef = math.clamp(sliderInt.Text, Minimum, Max) or math.clamp(50, Minimum, Max)
                        local oldDefaultScale =  (oldSliderDef - Minimum) / (Max - Minimum)
                        TweenService:Create(sliderInner, TweenInfo.new(0.15), {Size = UDim2.fromScale(oldDefaultScale, 1)}):Play()
                      end
                end  
            end)
            sliderButton.MouseButton1Down:Connect(function()
                local MouseMove, MouseKill
                MouseMove = Mouse.Move:Connect(function()
                    local Px = GetXY(sliderButton)
                    local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * Px
                    local Value = math.floor(Minimum + ((Max - Minimum) * Px))
                    SizeFromScale = SizeFromScale - (SizeFromScale % 2)
                    TweenService:Create(sliderInner, TweenInfo.new(0.15), {Size = UDim2.fromScale(Px, 1)}):Play()
                    sliderInt.Text = tostring(Value)
                    pcall(function()
                        Callback(Value)
                    end)
                    TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                end)
                MouseKill = game:GetService("UserInputService").InputEnded:Connect(function(UserInput)
                    if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                        MouseMove:Disconnect()
                        MouseKill:Disconnect()
                        TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                    end
                end)
            end)
            function sliderFunctions:ResetSlider()
               sliderInt.Text = Default 
               sliderInner.Size = UDim2.fromScale(DefaultScale,1)
               pcall(function()
                Callback(sliderInt.Text)
               end)
            end
            return sliderFunctions            
            elseif (toMake == "toggle") then
                -- \\ -> VARIABLES <- // --
                    local Title = settings.Title or "New Toggle"
                    local Default = settings.Default or false
                    local Callback = settings.Callback or function() end 
                    local toggleFrame = Instance.new("Frame")
                    local toggleButton = Instance.new("TextButton")
                    local stroke = Instance.new('UIStroke')
                    local toggleTitle = Instance.new("TextLabel")
                    local toggleTracker = Instance.new("Frame")
                    local toggleCheck = Instance.new("ImageButton")
                    local Toggled = false 
                    local stroke = Stroke(toggleFrame)
                    local ToggleFuncs = {}
                     -- \\ -> PROPS <- // --
                     toggleFrame.Parent = sectionFrame
                     toggleFrame.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)
                     toggleFrame.BackgroundColor3 = Themes.Dark.Elements_Back
                     Corner(toggleFrame,UDim.new(0,4))
                     Shadow(toggleFrame,Themes.Dark.Elements_Back)
                     toggleButton.Parent = toggleFrame
                     toggleButton.Size = UDim2.fromScale(1,1)
                     toggleButton.AutoButtonColor = false
                     toggleButton.BackgroundTransparency = 1 
                     toggleButton.Text = ""
                
                     toggleTitle.Parent = toggleFrame
                     toggleTitle.Size = UDim2.fromScale(1,1)
                     toggleTitle.Position = UDim2.fromScale(0,0) 
                     toggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                     toggleTitle.BackgroundTransparency = 1 
                     toggleTitle.TextColor3 = Themes.Dark.Elements_TextColor
                     toggleTitle.Font = Enum.Font.Gotham
                     toggleTitle.Text = Title
                     toggleTitle.TextSize = 12
                    Align(toggleTitle)
                    toggleTracker.Parent = toggleFrame
                    toggleTracker.AnchorPoint = Vector2.new(.5,.5)
                    toggleTracker.BackgroundColor3 = Themes.Dark.Elements_Overlay
                    toggleTracker.Position = UDim2.fromScale(1,.5) - UDim2.fromOffset(25,0)
                    toggleTracker.Size = UDim2.fromOffset(33,23)
                    Corner(toggleTracker,UDim.new(0,4))
                 local S = Shadow(toggleTracker,Themes.Dark.Elements_Overlay)
                    toggleCheck.Parent = toggleTracker
                    toggleCheck.Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,5)
                    toggleCheck.AnchorPoint = Vector2.new(.5,.5)
                    toggleCheck.ImageColor3 = Themes.Dark.Elements_Overlay
                    toggleCheck.Position = UDim2.fromScale(.5,.5)
                    toggleCheck.BackgroundTransparency = 1 
                    toggleCheck.Rotation = 90
                    toggleCheck.Image = "rbxassetid://3926305904"
                    toggleCheck.ImageRectOffset = Vector2.new(312, 4)
                    toggleCheck.ImageRectSize = Vector2.new(24, 24)
                    toggleCheck.ScaleType = Enum.ScaleType.Fit
                    stroke.Parent = toggleFrame
                    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    stroke.LineJoinMode = Enum.LineJoinMode.Round
                    stroke.Color = Themes.Dark.Elements_StrokeColor
                    stroke.LineJoinMode = Enum.LineJoinMode.Round
                    stroke.Thickness = 1
                    stroke.Transparency = 1 

                    local function enter()
                        TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                    end
                    local function leave()
                        TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                    end
                    local State = Default
                    if Default then
                       State = true
                    else
                       State = false
                    end
                    if Default then
                        pcall(Callback, State)
                        toggleCheck.Rotation = 0 
                        toggleTracker.BackgroundColor3 = Themes.Dark.Accent
                        S.ImageTransparency = 0
                            State = true
                        else
                            pcall(Callback, State)
                            toggleCheck.Rotation = 100
                            S.ImageTransparency =1
                             S.ImageTransparency = 1
                    State = false
                            end
                 
                            local function Toggle()
                                State = not State
                                pcall(Callback, State)
            
                                local NewColour = State and Themes.Dark.Accent or Themes.Dark.Elements_Overlay
                                local NewTrans = State and 0 or 90 
                                local NewImage  = State and 0 or 1 
                                TweenService:Create(S,TweenInfo.new(.25), { ImageTransparency = NewImage }):Play()
                                local alpha =  TweenService:Create(toggleCheck, TweenInfo.new(.25), {Rotation = NewTrans})
                                alpha:Play()
                                task.wait()
                                 local   delta = TweenService:Create(toggleTracker,TweenInfo.new(.25), { BackgroundColor3 = NewColour})
                                delta:Play()
                            end
                            toggleCheck.MouseButton1Click:Connect(Toggle)
                            toggleButton.MouseButton1Click:Connect(Toggle)
                            toggleFrame.MouseEnter:Connect(enter)
                            toggleFrame.MouseLeave:Connect(leave)
                            function ToggleFuncs:SetValue(value: boolean)
                                    State = value
                                    if State then
                                        pcall(Callback, State)
                                        TweenService:Create(toggleCheck,TweenInfo.new(.2),{Rotation = 0}):Play()
                                        TweenService:Create(toggleTracker,TweenInfo.new(.2),{ BackgroundColor3 = Themes.Dark.Accent}):Play()
                                        TweenService:Create(S,TweenInfo.new(.2),{ ImageTransparency = 0 }):Play()
                                        S.ImageTransparency = 0
                                        else
                                            pcall(Callback, State)
                                            TweenService:Create(toggleCheck,TweenInfo.new(.2),{Rotation = 100}):Play()
                                        TweenService:Create(toggleTracker,TweenInfo.new(.2),{ BackgroundColor3 = Themes.Dark.Elements_Overlay}):Play()
                                        TweenService:Create(S,TweenInfo.new(.2),{ ImageTransparency = 1 }):Play()
                                        end
                            end
                            return ToggleFuncs
                            elseif (toMake == "dropdown") then
                                local Title = settings.Title or "New Dropdown"
                                local Items = settings.Items or {}
                                local Callback = settings.Callback or function() end 
                                local dropFuncs = {}

                                local dropFrame = Instance.new("Frame")
                                local dropTitleBar = Instance.new("Frame")
                                local dropTitle = Instance.new("TextButton")
                                local dropCheck = Instance.new("ImageLabel")
                                local dropContent = Instance.new("Frame")
                                local dropList = Instance.new("UIListLayout")
                                local padTop = Instance.new("UIPadding")
                                dropFrame.Parent = sectionFrame
                                dropFrame.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)
                                dropFrame.BackgroundColor3 = Themes.Dark.Elements_Back
                                Corner(dropFrame,UDim.new(0,4))
                                Shadow(dropFrame,Themes.Dark.Elements_Back)
                                dropTitleBar.Parent = dropFrame
                                dropTitleBar.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,34)
                                dropTitleBar.BackgroundTransparency = 1 
                                dropTitle.Parent = dropTitleBar
                                dropTitle.Font = Enum.Font.Gotham
                                dropTitle.TextSize = 12 
                                dropTitle.TextColor3 = Themes.Dark.Elements_TextColor
                                dropTitle.Text = Title
                                dropTitle.Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0)
                                dropTitle.TextXAlignment = Enum.TextXAlignment.Left
                                dropTitle.BackgroundTransparency = 1 
                                Align(dropTitle)
                                dropCheck.Parent = dropTitleBar
                                dropCheck.BackgroundTransparency = 1.000
                                dropCheck.Size = UDim2.new(0, 19, 0, 15)
                                dropCheck.AnchorPoint = Vector2.new(.5,.5)
                                dropCheck.Position = UDim2.fromScale(1,.5) - UDim2.fromOffset(15,0)
                                dropCheck.Image = "rbxassetid://3926305904"
                                dropCheck.ImageColor3 = Themes.Dark.Accent
                                dropCheck.ImageRectOffset = Vector2.new(564, 284)
                                dropCheck.ImageRectSize = Vector2.new(36, 36)
                                dropCheck.ScaleType = Enum.ScaleType.Fit
                                dropContent.Parent = dropFrame
                                dropContent.Size = UDim2.fromScale(1,0)
                                dropContent.Position = UDim2.fromOffset(0,35)
                                dropContent.ClipsDescendants = true 
                                dropContent.BorderSizePixel = 0 
                                dropContent.BackgroundColor3 = Themes.Dark.Elements_Back
                                dropList.Parent = dropContent
                                dropList.SortOrder = Enum.SortOrder.LayoutOrder
                                dropList.Padding = UDim.new(0,5)
                                dropList.HorizontalAlignment = Enum.HorizontalAlignment.Center
                                padTop.Parent = dropContent 
                                padTop.PaddingTop = UDim.new(0,5)
                                local NumberOfOptions = #Items
                                local DropToggle = false
                                local DropdownSize
                       

                                table.foreach(Items, function(_, Value)
                                    local dropItem = Instance.new("TextButton")
                                    dropItem.Parent = dropContent
                                    dropItem.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-25,31)
                                    dropItem.Text = Value
                                    dropItem.Name = "dropItem"
                                    dropItem.BackgroundColor3 = Themes.Dark.Elements_Overlay
                                    dropItem.TextSize = 12 
                                    dropItem.Font = Enum.Font.Gotham
                                    dropItem.TextColor3 = Themes.Dark.Elements_TextColor
                                    dropItem.AutoButtonColor = false 
                                 
                                    local stroke = Stroke(dropItem,Themes.Dark.Accent)
                                    local function enter()
                                        TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                                    end
                                    local function leave()
                                        TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                                    end
                                    dropItem.MouseEnter:Connect(enter)
                                    dropItem.MouseLeave:Connect(leave)
                                    Corner(dropItem,UDim.new(0,5))

                                    local function Click()
                                        pcall(function()
                                            Callback(dropItem.Text)
                                        end)
                                        TweenService:Create(dropFrame,TweenInfo.new(.2), { Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)}):Play()
                                        TweenService:Create(dropContent,TweenInfo.new(.2), { Size = UDim2.fromScale(1,0)}):Play()
                                        DropToggle = false 
                                        dropTitle.Text = Title .. " - " .. dropItem.Text
                                    end

                                    dropItem.MouseButton1Click:Connect(Click)
                                end)
                                dropTitle.MouseButton1Click:Connect(function()
                                    DropToggle = not DropToggle

                                    TweenService:Create(dropCheck,TweenInfo.new(.2),{ Rotation = DropToggle and 180 or 0 }):Play()
                                    TweenService:Create(dropContent,TweenInfo.new(.2), { Size = DropToggle and UDim2.fromScale(1,0) + UDim2.fromOffset(0,dropList.AbsoluteContentSize.Y + 6) or UDim2.fromScale(1,0)}):Play()
                                    TweenService:Create(dropFrame,TweenInfo.new(.2), { Size = DropToggle and UDim2.fromScale(1,0) + UDim2.fromOffset(-15,dropList.AbsoluteContentSize.Y + 47) or UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36) }):Play()
                                end)
                            
                                local stroke = Stroke(dropFrame)
                                local function enter()
                                    TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                                end
                                local function leave()
                                    TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                                end
                                dropFrame.MouseEnter:Connect(enter)
                                dropFrame.MouseLeave:Connect(leave)

                                function dropFuncs:RefreshDropdown(settings)
                                        settings = settings or {}
                                        local newValues = settings.Items or {}
                                        for i,v in next, dropContent:GetChildren() do
                                            if v.Name == "dropItem" then
                                                v:Destroy()
                                            end
                                        end
                                        table.foreach(newValues, function(_, Value)
                                            local dropItem = Instance.new("TextButton")
                                            dropItem.Parent = dropContent
                                            dropItem.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-25,31)
                                            dropItem.Text = Value
                                            dropItem.BackgroundColor3 = Themes.Dark.Elements_Overlay
                                            dropItem.TextSize = 12 
					    dropItem.Name = "dropItem"
                                            dropItem.Font = Enum.Font.Gotham
                                            dropItem.TextColor3 = Themes.Dark.Elements_TextColor
                                            dropItem.AutoButtonColor = false 
                                            
                                            local stroke = Stroke(dropItem,Themes.Dark.Accent)
                                            local function enter()
                                                TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                                            end
                                            local function leave()
                                                TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                                            end
                                            dropItem.MouseEnter:Connect(enter)
                                            dropItem.MouseLeave:Connect(leave)
                                            Corner(dropItem,UDim.new(0,5))
        
                                            local function Click()
                                                pcall(function()
                                                    Callback(dropItem.Text)
                                                end)
                                                TweenService:Create(dropFrame,TweenInfo.new(.2), { Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)}):Play()
                                                TweenService:Create(dropContent,TweenInfo.new(.2), { Size = UDim2.fromScale(1,0)}):Play()
                                                DropToggle = false 
                                                dropTitle.Text = Title .. " - " .. dropItem.Text
                                            end
        
                                            dropItem.MouseButton1Click:Connect(Click)
                                        end)
                                end
                                return dropFuncs
                             
                                elseif (toMake == "dataset") then
                                    warn("datalist")
                                    local Title = settings.Title or "New Dropdown"
                                    local Items = settings.Items or {}
                                    local Callback = settings.Callback or function() end 
                                    local dropFuncs = {}
                                    local Dropdownd = {Value = {}, Toggled = false, Options = Items}

                                    local dropFrame = Instance.new("Frame")
                                    local dropTitleBar = Instance.new("Frame")
                                    local dropTitle = Instance.new("TextButton")
                                    local dropCheck = Instance.new("ImageLabel")
                                    local dropContent = Instance.new("Frame")
                                    local dropList = Instance.new("UIListLayout")
                                    local padTop = Instance.new("UIPadding")
                                    dropFrame.Parent = sectionFrame
                                    dropFrame.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)
                                    dropFrame.BackgroundColor3 = Themes.Dark.Elements_Back
                                    Corner(dropFrame,UDim.new(0,4))
                                    Shadow(dropFrame,Themes.Dark.Elements_Back)
                                    dropTitleBar.Parent = dropFrame
                                    dropTitleBar.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,34)
                                    dropTitleBar.BackgroundTransparency = 1 
                                    dropTitle.Parent = dropTitleBar
                                    dropTitle.Font = Enum.Font.Gotham
                                    dropTitle.TextSize = 12 
                                    dropTitle.TextColor3 = Themes.Dark.Elements_TextColor
                                    dropTitle.Text = Title
                                    dropTitle.Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0)
                                    dropTitle.TextXAlignment = Enum.TextXAlignment.Left
                                    dropTitle.BackgroundTransparency = 1 
                                    Align(dropTitle)
                                    dropCheck.Parent = dropTitleBar
                                    dropCheck.BackgroundTransparency = 1.000
                                    dropCheck.Size = UDim2.new(0, 19, 0, 15)
                                    dropCheck.AnchorPoint = Vector2.new(.5,.5)
                                    dropCheck.Position = UDim2.fromScale(1,.5) - UDim2.fromOffset(15,0)
                                    dropCheck.Image = "rbxassetid://3926305904"
                                    dropCheck.ImageColor3 = Themes.Dark.Accent
                                    dropCheck.ImageRectOffset = Vector2.new(564, 284)
                                    dropCheck.ImageRectSize = Vector2.new(36, 36)
                                    dropCheck.ScaleType = Enum.ScaleType.Fit
                                    dropContent.Parent = dropFrame
                                    dropContent.Size = UDim2.fromScale(1,0)
                                    dropContent.Position = UDim2.fromOffset(0,35)
                                    dropContent.ClipsDescendants = true 
                                    dropContent.BorderSizePixel = 0 
                                    dropContent.BackgroundColor3 = Themes.Dark.Elements_Back
                                    dropList.Parent = dropContent
                                    dropList.SortOrder = Enum.SortOrder.LayoutOrder
                                    dropList.Padding = UDim.new(0,5)
                                    dropList.HorizontalAlignment = Enum.HorizontalAlignment.Center
                                    padTop.Parent = dropContent 
                                    padTop.PaddingTop = UDim.new(0,5)
                                    local NumberOfOptions = #Items
                                    local DropToggle = false
                                    local DropdownSize
                           
    
                                        local dropItem = Instance.new("TextButton")
                                        dropItem.Parent = motherFrame
                                        dropItem.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-25,31)
                                        dropItem.Text = ""
                                        dropItem.Name = "dropItem"
                                        dropItem.BackgroundColor3 = Themes.Dark.Elements_Overlay
                                        dropItem.TextSize = 12 
                                        dropItem.Font = Enum.Font.Gotham
                                        dropItem.TextColor3 = Themes.Dark.Elements_TextColor
                                        dropItem.AutoButtonColor = false 
                                        dropItem.Visible = false 
                                            local stroke = Stroke(dropItem,Themes.Dark.Accent)
                                        stroke.Name = "Stroke"
                                        local function enter()
                                            TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                                        end
                                        local function leave()
                                            TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                                        end
                                        dropItem.MouseEnter:Connect(enter)
                                        dropItem.MouseLeave:Connect(leave)
                                        Corner(dropItem,UDim.new(0,5))
    
                                        local function Click()
                                            pcall(function()
                                                Callback(dropItem.Text)
                                            end)
                                            TweenService:Create(dropFrame,TweenInfo.new(.2), { Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)}):Play()
                                            TweenService:Create(dropContent,TweenInfo.new(.2), { Size = UDim2.fromScale(1,0)}):Play()
                                            DropToggle = false 
                                            dropTitle.Text = Title .. " - " .. dropItem.Text
                                        end
    
                                        dropItem.MouseButton1Click:Connect(Click)
                                    local function AddOptions(opts)
                                        for _,option in pairs(opts) do
                                            local Option = dropItem:Clone()
                                            Option.Parent = dropContent
                                            Option.Text = option
                                            Option.Visible = true 
                                            Option.ClipsDescendants = true
                                            Option.MouseEnter:Connect(function(x, y)
                                        TweenService:Create(Option.Stroke,TweenInfo.new(.2), { Transparency = 0 }):Play()
                                    end)
                                    Option.MouseLeave:Connect(function(x, y)
                                        TweenService:Create(Option.Stroke,TweenInfo.new(.2), { Transparency = 1 }):Play()
                                    end)
                                            Option.MouseButton1Click:Connect(function()
                                                if table.find(Dropdownd.Value, option) then				
                                                    table.remove(Dropdownd.Value, table.find(Dropdownd.Value, option))
                                                    dropTitle.Text = Title .. " - " .. table.concat(Dropdownd.Value, ", ")
                                                    pcall(Callback,Dropdownd.Value)
                                                else
                                                    table.insert(Dropdownd.Value, option)
                                                    dropTitle.Text = Title .. " - " .. table.concat(Dropdownd.Value, ", ")
                                                    pcall(Callback,Dropdownd.Value)
                                                end
                                            end)
                                        end   
                                    end    
                                    local stroke = Stroke(dropFrame)
                                    local function enter()
                                        TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                                    end
                                    local function leave()
                                        TweenService:Create(stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                                    end
                                    dropFrame.MouseEnter:Connect(enter)
                                    dropFrame.MouseLeave:Connect(leave)
                                    AddOptions(Items)
                                    dropTitle.MouseButton1Click:Connect(function()
                                        DropToggle = not DropToggle
    
                                        TweenService:Create(dropCheck,TweenInfo.new(.2),{ Rotation = DropToggle and 180 or 0 }):Play()
                                        TweenService:Create(dropContent,TweenInfo.new(.2), { Size = DropToggle and UDim2.fromScale(1,0) + UDim2.fromOffset(0,dropList.AbsoluteContentSize.Y + 6) or UDim2.fromScale(1,0)}):Play()
                                        TweenService:Create(dropFrame,TweenInfo.new(.2), { Size = DropToggle and UDim2.fromScale(1,0) + UDim2.fromOffset(-15,dropList.AbsoluteContentSize.Y + 47) or UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36) }):Play()
                                    end)
                                    function dropFuncs:Refresh(settings)
                                        settings = settings or {}
                                        local newItems = settings.Items or {}
                    
                                        for i,v in next, dropContent:GetChildren() do
                                            if v.Name == "dropItem" then
                                                v:Destroy()
                                        end
                                    end
                                    AddOptions(newItems)
                                    function dropFuncs:Set(settings)
                                        settings = settings or {}
                                        local newV = settings.Value 
                                        Dropdownd.Value = newV
                                        Title.Text = Title.Text .. " - " .. table.concat(Dropdownd.Value, ", ")
                                        return Callback(Dropdownd.Value) 
                                    end
                                    return dropFuncs    
                                end
                                elseif (toMake == "keybind") then
                                    local Title = settings.Title or "New Keybind" 
                                    local Key = settings.Key or Enum.KeyCode.F 
                                    local Callback = settings.Callback or function() end 
                                    local oldKey = Key.Name

                                    local keybindFrame = Instance.new("Frame")
                                    local keybindTitle = Instance.new("TextLabel")
                                    local keybindTracker = Instance.new("TextButton")
                                    local Stroke = Stroke(keybindFrame)

                                    keybindFrame.Parent = sectionFrame
                                    keybindFrame.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)
                                    keybindFrame.BackgroundColor3 = Themes.Dark.Elements_Back
                                    Corner(keybindFrame, UDim.new(0,4))
                                    Shadow(keybindFrame,Themes.Dark.Elements_Back)
                                    keybindTitle.Parent = keybindFrame
                                    keybindTitle.Size = UDim2.fromScale(1,1)
                                    keybindTitle.Font = Enum.Font.Gotham
                                    keybindTitle.TextSize = 12 
                                    keybindTitle.BackgroundTransparency = 1 
                                    keybindTitle.TextXAlignment = Enum.TextXAlignment.Left
                                    keybindTitle.Text = Title
                                    keybindTitle.TextColor3 = Themes.Dark.Elements_TextColor
                                    Align(keybindTitle)
                                    keybindTracker.Parent = keybindFrame
                                    keybindTracker.Text = oldKey
                                    keybindTracker.Font = Enum.Font.Gotham
                                    keybindTracker.TextSize = 11 
                                    keybindTracker.TextColor3 = Themes.Dark.Elements_TextColor
                                    keybindTracker.AutoButtonColor = false 
                                    keybindTracker.AnchorPoint = Vector2.new(.5,.5)
                                    keybindTracker.BackgroundColor3 = Themes.Dark.Elements_Overlay
                                    keybindTracker.Position = UDim2.fromScale(1,.5) - UDim2.fromOffset(35,0)
                                    keybindTracker.Size = UDim2.fromOffset(55,23)
                                    Corner(keybindTracker,UDim.new(0,4))
                                    Shadow(keybindTracker,Themes.Dark.Elements_Back)


                                    keybindTracker.MouseButton1Click:Connect(function()
                                        TweenService:Create(Stroke,TweenInfo.new(.2), { Transparency = 0 }):Play()
                                        keybindTracker.TextSize = 0 
                                           TweenService:Create(keybindTracker,TweenInfo.new(.2),{ TextSize = 15}):Play()
                                           keybindTracker.Text = "..."
                                           wait(.2)
                                           TweenService:Create(keybindTracker,TweenInfo.new(.2),{TextSize = 13}):Play()
                                           keybindTracker.Text = "..."
                                           local a, b = game:GetService('UserInputService').InputBegan:wait();
                                           if a.KeyCode.Name ~= "Unknown" then
                                            keybindTracker.Text = a.KeyCode.Name
                                               oldKey = a.KeyCode.Name;
                                               TweenService:Create(Stroke,TweenInfo.new(.2), { Transparency = 1 }):Play()
                                           end
                                       end)
                                   local b =     game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
                                           if not ok then 
                                               if current.KeyCode.Name == oldKey then 
                                                   pcall(function()
                                                       Callback()
                                                   end)
                                               end
                                           end
                                       end)
                                       game:GetService("CoreGui").ChildRemoved:Connect(function(child)
                                                   if child.Name == "Base" then
                                                       b:Disconnect()
                                                   end
                                           end)


                                           elseif (toMake == "textfield") then
                                            warn("textfield")
                                            local Title = settings.Title or "New Textfield"
                                            local Placehold = settings.Placeholder or ""
                                            local Callback = settings.Callback or function() end 
            
                                            local a = Instance.new("Frame")
                                            local keybindTitle = Instance.new("TextLabel")
                                            local keybindTracker = Instance.new("TextBox")
                                            local tetBut = Instance.new("TextButton")
                                            local Stroke = Stroke(a)
            
                                            a.Parent = sectionFrame
                                            a.Size = UDim2.fromScale(1,0) + UDim2.fromOffset(-15,36)
                                            a.BackgroundColor3 = Themes.Dark.Elements_Back
                                            tetBut.Parent = a 
                                            tetBut.Size = UDim2.fromScale(1,1)
                                            tetBut.BackgroundTransparency = 1 
                                            tetBut.Text = ""
                                            Corner(a, UDim.new(0,4))
                                            Shadow(a,Themes.Dark.Elements_Back)
                                            keybindTitle.Parent = a
                                            keybindTitle.Size = UDim2.fromScale(1,1)
                                            keybindTitle.Font = Enum.Font.Gotham
                                            keybindTitle.TextSize = 12 
                                            keybindTitle.BackgroundTransparency = 1 
                                            keybindTitle.TextXAlignment = Enum.TextXAlignment.Left
                                            keybindTitle.Text = Title
                                            keybindTitle.TextColor3 = Themes.Dark.Elements_TextColor
                                            Align(keybindTitle)
                                            keybindTracker.Parent = a
                                            keybindTracker.Text = ""
                                            keybindTracker.PlaceholderText = Placehold
                                            keybindTracker.Font = Enum.Font.Gotham
                                            keybindTracker.TextSize = 10
                                            keybindTracker.TextColor3 = Themes.Dark.Elements_TextColor
                                            keybindTracker.AnchorPoint = Vector2.new(.5,.5)
                                            keybindTracker.BackgroundColor3 = Themes.Dark.Elements_Overlay
                                            keybindTracker.Position = UDim2.fromScale(1,.5) - UDim2.fromOffset(35,0)
                                            keybindTracker.Size = UDim2.fromOffset(55,23)
                                            keybindTracker.ClipsDescendants = true
                                            Corner(keybindTracker,UDim.new(0,4))
                                            Shadow(keybindTracker,Themes.Dark.Elements_Back)
            
                                            tetBut.MouseButton1Click:Connect(function()
                                                keybindTracker:CaptureFocus()
                                            end)
            
                                                local function enter()
                                                    TweenService:Create(Stroke,TweenInfo.new(.2),{ Transparency = 0 }):Play()
                                                end
                                                local function leave()
                                                    TweenService:Create(Stroke,TweenInfo.new(.2),{ Transparency = 1 }):Play()
                                                end
                                                keybindTracker.Focused:Connect(enter)
                                           
                                            keybindTracker.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                                                leave()
                                                if enterPressed then
                                                    pcall(function()
                                                        Callback(keybindTracker.Text)
                                                    end)
                                                end
                                            end)
                                            
                            end     
                          
                        end
                    end
                    return E
        end
        return Create2
    end
    return Create
end
return Compactio
