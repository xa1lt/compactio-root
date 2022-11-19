local Compactio = loadstring(game:HttpGet("https://raw.githubusercontent.com/xa1lt/compactio-root/main/Source.lua"))()
local Box = Compactio.Render({
    Title = "Compactio",
    Save = true,
    Options = 
    {
        SizeX = 450,
        SizeY = 450
    }
})
local Tab = Box.Tab({
    Title = "Tab #1"
})
local Tab2 = Box.Tab({
    Title = "Tab #2"
})
local Section = Tab.Section({
    Title = "Section #1"
})
local Section2 = Tab.Section({
    Title = "Section #2"
})
Section.new({
    Type = "Button",
    Title = "Button",
    Callback = function()
        warn("You clicked a button!")
    end
})
local L = Section.new({
    Type = "Label",
    Title = "Label"
})
local slider = Section.new({
    Type = "Slider",
    Title = "Slider",
    Min = 0,
    Max = 10,
    Default = 5,
    Callback = function(v)
        warn(v)
    end
})
local toggle = Section.new({
    Type = "Toggle",
    Title = "Toggle (active)",
    Default =  true,
    Callback = function(v)
        warn(v)
    end
})
local toggle2= Section.new({
    Type = "Toggle",
    Title = "Toggle (unactive)",
    Default =  false,
    Callback = function(v)
        warn(v)
    end
})
local b = Section.new({
    Type = "Button",
    Title = "Reset Toggle",
    Callback = function()
        toggle:SetValue(false)
    end
})
local c = Section.new({
    Type = "Dropdown",
    Title = "Dropdown",
    Items = {"One","Two","Three","4","5","6"},
    Callback = function(v)
        warn(v)
    end
})
local ref = Section.new({
    Type = "Button",
    Title = "Refresh Dropdown",
    Callback = function()
        c:RefreshDropdown({
            Items = {"1","2","3"}
        })
    end
})
local data = Section.new({
    Type = "dataset",
    Title = "Dataset",
    Items = {"1","2","3"},
    Callback = function(v)
        print(table.concat(v, ", "))
    end
})
local keybind = Section2.new({
    Type = "Keybind",
    Title = "Keybind",
    Key = Enum.KeyCode.RightAlt,
    Callback = function()
        warn("You pressed me!")
    end
})
local textfield = Section2.new({
    Type = "TextField",
    Title = 'Text-Field',
    Placeholder = "Input Here",
    Callback = function(v)
        warn(v)
    end
})
