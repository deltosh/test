if game:GetService("AdService"):FindFirstChild("Advertisement") then
	game:GetService("AdService").Advertisement:Destroy()
end

if getgenv()._SalboCleanup then
	pcall(getgenv()._SalboCleanup)
	task.wait(0.15)
end

getgenv().Core = {}

local Core = getgenv().Core

Core.Version = "1.0.0"
Core.Loaded = true

Core.Services = {}
Core.Features = {}
Core.Connections = {}
Core.Keybinds = {}
Core.Hooks = {}

local Services = Core.Services

Services.Players = game:GetService("Players")
Services.RunService = game:GetService("RunService")
Services.ReplicatedStorage = game:GetService("ReplicatedStorage")
Services.UserInputService = game:GetService("UserInputService")
Services.TeleportService = game:GetService("TeleportService")
Services.Lighting = game:GetService("Lighting")

local LocalPlayer = Services.Players.LocalPlayer

local Camera = workspace.CurrentCamera

local PlayerESPLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jaeelin/Ascendent-ESP/refs/heads/main/PlayerESP.lua"))()

local AddWindow = (function()
local function gs(service) return game:GetService(service) end
local _tweenservice, _runservice, _coregui, _uis, _http = gs("TweenService"), gs("RunService"), gs("CoreGui"), gs("UserInputService"), gs("HttpService")
local mouse = gs("Players").LocalPlayer:GetMouse()
local Library = {
Ui_Bind = Enum.KeyCode.RightShift,
Colors = {
Window = Color3.fromRGB(28, 30, 36),
BorderColor = Color3.fromRGB(70, 74, 88),
Accent = Color3.fromRGB(139, 158, 252), 
TopBar = Color3.fromRGB(34, 36, 44),
TopText = Color3.fromRGB(210, 214, 225),
TabContainer = Color3.fromRGB(28, 30, 36),
TabActive = Color3.fromRGB(245, 247, 255),
TabInactive = Color3.fromRGB(170, 176, 190),
ContentContainer = Color3.fromRGB(28, 30, 36),
Section = Color3.fromRGB(34, 36, 44),
SectionText = Color3.fromRGB(200, 206, 220),
RiskyActive = Color3.fromRGB(230, 70, 70),
RiskyInactive = Color3.fromRGB(160, 60, 60),
ElementActive = Color3.fromRGB(230, 234, 245),
ElementInactive = Color3.fromRGB(175, 180, 195),
ElementBack = Color3.fromRGB(48, 52, 64),
},
Instances = {},
Connections = {},
Font = nil,
}
Library.Font = Font.fromEnum(Enum.Font.Code)
function Library:Create(Class, Properties, Secure)
local _Instance
if Secure then
_Instance = cloneref(Instance.new(Class))
else _Instance = type(Class) == 'string' and Instance.new(Class) or Class end
for Property, Value in next, Properties do
_Instance[Property] = Value
end
table.insert(Library.Instances, _Instance)
return _Instance
end
function Library:validate(defaults, options)
for i,v in pairs(defaults) do
if options[i] == nil then
options[i] = v
end
end
return options
end
function Library:connection(signal, callback, tbl)
local connection = signal:Connect(callback)
table.insert(self.Connections, connection)
if tbl then table.insert(tbl, connection) end
return connection
end
function Library:unload()
for _,v in next, self.Instances do v:Destroy() end
for _,v in next, self.Connections do v:Disconnect() end
end
function Library:tween(object, goal, callback)
local tween = _tweenservice:Create(object, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), goal)
tween.Completed:Connect(callback or function() end)
tween:Play()
end
function lerp(startValue, endValue, duration, callback)
local startTime = tick() 
local completed = false
task.spawn(function()
while true do
local currentTime = tick() - startTime
if currentTime >= duration then
callback(endValue)
completed = true
break
end
local progress = currentTime / duration
local lerped = startValue + (endValue - startValue) * (1 - (1 - progress) * (1 - progress))
callback(lerped)
task.wait()
end
end)
while not completed do
task.wait()
end
end
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")
local productInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local gameName = productInfo.Name
local dropdownindex = 50
function AddWindow(options)
local options = options or {}
options = Library:validate({
name = string.format('odyssey <font color="rgb(%d, %d, %d)">[v1.0]</font> | developed by source.lua', Library.Colors.Accent.R * 255, Library.Colors.Accent.G * 255, Library.Colors.Accent.B * 255),
size = UDim2.new(0, 625, 0, 400),
}, options or {})
local menu = {CurrentTab = nil}
local SCREENGUI = Library:Create("ScreenGui", {
Parent = _coregui,
ZIndexBehavior = Enum.ZIndexBehavior.Global,
Name = options.name
}, True)
local WINDOW = Library:Create("Frame", {
Parent = SCREENGUI,
Size = options.size,
AnchorPoint = Vector2.new("0.5","0.5"),
Position = UDim2.new(0.5, -100, 0.5, 0),
BackgroundColor3 = Library.Colors.Window,
BorderSizePixel = 0,
Name = "Window",
ZIndex = -2,
})
local WINDOW_OUTLINE = Library:Create("Frame", {
Parent = WINDOW,
Size = UDim2.new(1,-2,1,-2),
AnchorPoint = Vector2.new("0.5","0.5"),
Position = UDim2.new(0.5, 0, 0.5, 0),
BackgroundTransparency = 1,
Name = "Outline",
ZIndex = -1,
})
Library:Create("UIStroke", { 
Parent = WINDOW_OUTLINE,
Color = Library.Colors.BorderColor,
LineJoinMode = Enum.LineJoinMode.Miter,
})
Library:Create("TextButton", {
Parent = WINDOW,
Size = UDim2.new(0, 1, 0, 1),
BackgroundTransparency = 1,
TextTransparency = 1,
BorderSizePixel = 0,
Name = "mb",
Modal = true
})
local TOPBAR = Library:Create("Frame", {
Parent = WINDOW,
BackgroundColor3 = Library.Colors.TopBar,
BorderSizePixel = 0,
Size = UDim2.new(1, -6, 0, 18),
Position = UDim2.new(0,3,0,3),
Name = "Topbar"
})
Library:Create("Frame", { 
Parent = TOPBAR,
BackgroundColor3 = Library.Colors.Accent,
BorderSizePixel = 0,
Size = UDim2.new(1,4,0,1),
Position = UDim2.new(0.5,0,1,1),
AnchorPoint = Vector2.new(0.5,1),
})
local TOP_OVERLAY = Library:Create("Frame", {
Parent = TOPBAR,
BackgroundColor3 = Library.Colors.Accent,
BorderSizePixel = 0,
Size = UDim2.new(1,4,1,0),
Position = UDim2.new(0.5,0,1,2),
AnchorPoint = Vector2.new(0.5,1),
ZIndex = 2
})
Library:Create("UIGradient", { 
Parent = TOP_OVERLAY,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(0.8, 0.7),
NumberSequenceKeypoint.new(1, 1.0),
}),
Rotation = 90
})
Library:Create("TextLabel", { 
Parent = TOPBAR,
Size = UDim2.new(0, 0, 1, 0),
Position = UDim2.new(0,6,0,0),
TextColor3 = Library.Colors.TopText,
BorderSizePixel = 0,
TextSize = 11,
RichText = true,
Text = options.name,
FontFace = Library.Font,
TextXAlignment = Enum.TextXAlignment.Left,
Name = "Title"
})
Library:Create("TextLabel", { 
Parent = TOPBAR,
Size = UDim2.new(0, 0, 1, 0),
Position = UDim2.new(1,-6,0.5,0),
AnchorPoint = Vector2.new(1,0.5),
TextColor3 = Library.Colors.TopText,
BorderSizePixel = 0,
TextSize = 11,
RichText = true,
Text = string.lower(os.date("%A, %d %B, %y")),
FontFace = Library.Font,
TextXAlignment = Enum.TextXAlignment.Right,
Name = "Title"
})
local TABCONTAINER = Library:Create("Frame", {
Parent = WINDOW,
BackgroundTransparency = 1,
Size = UDim2.new(0,120,1,-35),
Position = UDim2.new(0,10,0.5,10),
AnchorPoint = Vector2.new(0,0.5),
Name = "TabContainer"
})
Library:Create("UIPadding", { 
Parent = TABCONTAINER,
PaddingTop = UDim.new(0, 10),
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10)
})
Library:Create("UIListLayout", { 
Parent = TABCONTAINER,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Vertical,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
})
Library:Create("UIStroke", { 
Parent = TABCONTAINER,
Color = Library.Colors.BorderColor
})
local INNERCONTAINER = Library:Create("Frame", {
Parent = WINDOW,
Size = UDim2.new(1, -150, 1, -35),
Position = UDim2.new(0, 140, 0, 28),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Name = "InnerContainer",
})
Library:Create("UIStroke", { 
Parent = INNERCONTAINER,
Color = Library.Colors.BorderColor,
LineJoinMode = Enum.LineJoinMode.Miter,
})
local function deactivate(tab)
for _, content in ipairs(INNERCONTAINER:GetChildren()) do
if content.Name == tab.Name then
content.Visible = false
end
end
Library:tween(tab.TabText, {Position = UDim2.new(0,12,0.5,0),})
Library:tween(tab.TabBar, {Position = UDim2.new(0,0,0.5,0),})
Library:tween(tab.TabOverlay, {Position = UDim2.new(0,0,0,0)})
Library:tween(tab.TabText, {TextColor3 = Library.Colors.TabInactive})
Library:tween(tab.TabOverlay, {BackgroundTransparency = 1})
end
function menu:AddTab(options)
options = Library:validate({
name = "example"
}, options or {})
local tab = {}
local TAB = Library:Create("Frame", {
Parent = TABCONTAINER,
BackgroundTransparency = 1,
Size = UDim2.new(1,0,0,15),
Name = options.name
})
local TAB_OVERLAY = Library:Create("Frame", {
Parent = TAB,
Size = UDim2.new(1,0,1,0),
BackgroundTransparency = 1,
BackgroundColor3 = Library.Colors.Accent,
Name = "TabOverlay"
})
Library:Create("UIGradient", { 
Parent = TAB_OVERLAY,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0.8),
NumberSequenceKeypoint.new(0.4, 1),
NumberSequenceKeypoint.new(1, 1),
}),
})
local TABBAR = Library:Create("Frame", {
Parent = TAB,
BackgroundColor3 = Library.Colors.Accent,
Size = UDim2.new(0,1,1,0),
Position = UDim2.new(0,0,0.5,0),
AnchorPoint = Vector2.new(0,0.5),
Name = "TabBar"
})
local TABTEXT = Library:Create("TextLabel", {
Parent = TAB,
BackgroundTransparency = 1,
Size = UDim2.new(1,-12,1,0),
Position = UDim2.new(0,12,0.5,0),
AnchorPoint = Vector2.new(0,0.5),
TextColor3 = Library.Colors.TabInactive,
FontFace = Library.Font,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
Text = options.name,
Name = "TabText"
})
local CONTENTCONTAINER = Library:Create("Frame", {
Parent = INNERCONTAINER,
Size = UDim2.new(1, 0, 1, 0),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.5, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
Name = options.name
})
local LEFTCONTAINER = Library:Create("Frame", {
Parent = CONTENTCONTAINER,
Size = UDim2.new(0.5, -6, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Name = "LeftContainer"
})
Library:Create("UIPadding", {
Parent = LEFTCONTAINER,
PaddingTop = UDim.new(0,10),
PaddingBottom = UDim.new(0,10),
PaddingLeft = UDim.new(0,10),
})
local RIGHTCONTAINER = Library:Create("Frame", {
Parent = CONTENTCONTAINER,
Size = UDim2.new(0.5, -6, 1, 0),
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, 0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Name = "RightContainer"
})
Library:Create("UIPadding", {
Parent = RIGHTCONTAINER,
PaddingTop = UDim.new(0,10),
PaddingBottom = UDim.new(0,10),
PaddingRight = UDim.new(0,10),
})
do 
local function Activate()
CONTENTCONTAINER.Visible = true
Library:tween(TABTEXT, {Position = UDim2.new(0,18,0.5,0),})
Library:tween(TABBAR, {Position = UDim2.new(0,6,0.5,0),})
Library:tween(TAB_OVERLAY, {Position = UDim2.new(0,6,0,0),})
Library:tween(TABTEXT, {TextColor3 = Library.Colors.TabActive})
Library:tween(TABBAR, {BackgroundTransparency = 0})
menu.CurrentTab = TAB
end
local function switchTab(tab)
Library:tween(TABTEXT, {TextColor3 = Library.Colors.TabActive})
Library:tween(TAB_OVERLAY, {BackgroundTransparency = 0})
for _, content in pairs(TABCONTAINER:GetChildren()) do 
if content:IsA("Frame") and content.Name ~= tab.Name then
deactivate(content) 
end
end
Activate(tab)
end
Library:connection(TAB.MouseEnter, function()
if menu.CurrentTab ~= TAB then Library:tween(TABTEXT, {TextColor3 = Library.Colors.TabActive}) end
local input = Library:connection(_uis.InputBegan, function(key)
if key.UserInputType == Enum.UserInputType.MouseButton1 then
switchTab(TAB)
end
end)
local leave
leave = Library:connection(TAB.MouseLeave, function()
if menu.CurrentTab ~= TAB then Library:tween(TABTEXT, {TextColor3 = Library.Colors.TabInactive}) end
input:disconnect()
leave:disconnect()
end)
end)
if menu.CurrentTab == nil then
switchTab(TAB)
end
end
local SUBTABCONTAINER
local LeftHeight = {}
local RightHeight = {}
local NewPos = 0
getgenv().subtab = false
local function subdeactivate(subtab)
local ContentContainer = INNERCONTAINER[subtab.Parent.Parent.Name]
for _, content in ipairs(ContentContainer:GetChildren()) do
if content.Name == subtab.Name then
content.Visible = false
end
end
Library:tween(subtab.SubTabText, {TextColor3 = Library.Colors.TabInactive})
Library:tween(subtab.SubTabBar, {BackgroundTransparency = 1})
end
function tab:AddTab(options)
options = Library:validate({
name = "preview",
}, options or {})
local tab = {CurrentTab = nil}
getgenv().subtab = true
local SUBLEFTCONTAINER = LEFTCONTAINER:Clone()
local SUBRIGHTCONTAINER = RIGHTCONTAINER:Clone()
if LEFTCONTAINER and RIGHTCONTAINER then
LEFTCONTAINER:Destroy()
RIGHTCONTAINER:Destroy()
end
if not SUBLEFTCONTAINER:FindFirstChild("UIPadding") then
Library:Create("UIPadding", {
Parent = SUBLEFTCONTAINER,
PaddingTop = UDim.new(0,10),
PaddingBottom = UDim.new(0,10),
PaddingLeft = UDim.new(0,10),
})
end
if not SUBRIGHTCONTAINER:FindFirstChild("UIPadding") then
Library:Create("UIPadding", {
Parent = SUBRIGHTCONTAINER,
PaddingTop = UDim.new(0,10),
PaddingBottom = UDim.new(0,10),
PaddingRight = UDim.new(0,10),
})
end
if not CONTENTCONTAINER:FindFirstChild("SubTabContainer") then
SUBTABCONTAINER = Library:Create("Frame", {
Parent = CONTENTCONTAINER,
Size = UDim2.new(1,0,0,20),
Name = "SubTabContainer"
})
Library:Create("UIListLayout", {
Parent = SUBTABCONTAINER,
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
SortOrder = Enum.SortOrder.LayoutOrder,
})
Library:Create("UIStroke", {
Parent = SUBTABCONTAINER,
Color = Library.Colors.BorderColor
})
Library:Create("UIGradient", { 
Parent = SUBTABCONTAINER,
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
ColorSequenceKeypoint.new(0.7, Color3.fromRGB(Library.Colors.Section)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(Library.Colors.Section))
},
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(0.85, 1),
NumberSequenceKeypoint.new(1, 1),
}),
Rotation = 90,
})
end
local SUBTAB = Library:Create("Frame", {
Parent = SUBTABCONTAINER,
BorderSizePixel = 0,
BackgroundTransparency = 1,
Size = UDim2.new(1,0,1,0),
Name = options.name
})
do 
local tabCount = 0
for _, subtab in ipairs(SUBTABCONTAINER:GetChildren()) do
if subtab:IsA("Frame") then
tabCount = tabCount + 1
end
end
local finalValue = math.round(SUBTABCONTAINER.AbsoluteSize.X / tabCount)
for _, subtab in ipairs(SUBTABCONTAINER:GetChildren()) do
if subtab:IsA("Frame") then
subtab.Size = UDim2.new(0, finalValue, 1, 0)
end
end
end
local SUBTABTEXT = Library:Create("TextLabel", { 
Parent = SUBTAB,
BackgroundTransparency = 1,
TextColor3 = Library.Colors.TabInactive,
FontFace = Library.Font,
TextSize = 11,
Size = UDim2.new(1,0,1,0),
Text = options.name,
Name = "SubTabText"
})
local SUBTABBAR = Library:Create("Frame", {
Parent = SUBTAB,
BackgroundColor3 = Library.Colors.Accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
AnchorPoint = Vector2.new(0.5,1),
Position = UDim2.new(0.5,0,1,2),
Size = UDim2.new(1,0,0,1),
Name = "SubTabBar"
})
local SUBCONTENTCONTAINER = Library:Create("Frame", {
Parent = CONTENTCONTAINER,
BackgroundTransparency = 1,
Visible = false,
Position = UDim2.new(0,0,0,25),
Size = UDim2.new(1,0,1,-25),
Name = options.name
})
local LEFTCONTAINER = SUBLEFTCONTAINER
local RIGHTCONTAINER = SUBRIGHTCONTAINER
LEFTCONTAINER.Parent = SUBCONTENTCONTAINER
RIGHTCONTAINER.Parent = SUBCONTENTCONTAINER
LeftHeight[options.name] = {}
RightHeight[options.name] = {}
do 
local function Activate()
SUBCONTENTCONTAINER.Visible = true
Library:tween(SUBTABTEXT, {TextColor3 = Library.Colors.TabActive})
Library:tween(SUBTABBAR, {BackgroundTransparency = 0})
tab.CurrentTab = SUBTAB
end
local function switchTab(subtab)
Library:tween(SUBTABTEXT, {TextColor3 = Library.Colors.TabActive})
Library:tween(SUBTABBAR, {BackgroundTransparency = 0})
for _, content in pairs(SUBTABCONTAINER:GetChildren()) do 
if content:IsA("Frame") and content.Name ~= subtab.Name then
subdeactivate(content) 
end
end
Activate(subtab)
end
Library:connection(SUBTAB.MouseEnter, function()
if tab.CurrentTab ~= SUBTAB then Library:tween(SUBTABTEXT, {TextColor3 = Library.Colors.TabActive}) end
local input = Library:connection(_uis.InputBegan, function(key)
if key.UserInputType == Enum.UserInputType.MouseButton1 then
switchTab(SUBTAB)
end
end)
local leave
leave = Library:connection(SUBTAB.MouseLeave, function()
if tab.CurrentTab ~= SUBTAB then Library:tween(SUBTABTEXT, {TextColor3 = Library.Colors.TabInactive}) end
input:disconnect()
leave:disconnect()
end)
end)
if tab.CurrentTab == nil then
switchTab(SUBTAB)
end
end
return tab
end
function tab:AddSection(options)
options = Library:validate({
tab = nil,
name = "preview",
side = "Left",
height = "fill" 
}, options or {})
local section = { Hover = false, }
local NewPos
if options.side == "Left" then
if getgenv().subtab then
local subtab = options.tab
if LeftHeight[subtab] and #LeftHeight[subtab] > 0 then
NewPos = LeftHeight[subtab][#LeftHeight[subtab]] + 30
else
NewPos = 15
end
else
if LeftHeight and #LeftHeight > 0 then
NewPos = LeftHeight[#LeftHeight] + 30
else
NewPos = 15
end
end
else
if getgenv().subtab then
local subtab = options.tab
if RightHeight[subtab] and #RightHeight[subtab] > 0 then
NewPos = RightHeight[subtab][#RightHeight[subtab]] + 30
else
NewPos = 15
end
else
if RightHeight and #RightHeight > 0 then
NewPos = RightHeight[#RightHeight] + 30
else
NewPos = 15
end
end
end
local SECTION = Library:Create("Frame", {
Size = UDim2.new(1, 0, 0, options.height),
AnchorPoint = Vector2.new(0, 0),
BackgroundColor3 = Library.Colors.Section,
Position = UDim2.new(0, 0, 0, NewPos - 12),
BorderSizePixel = 0,
Name = options.name
})
local SECTIONTEXT = Library:Create("TextLabel", {
Parent = SECTION,
AnchorPoint = Vector2.new(0.5,0),
Position = UDim2.new(0.5,0,0,-6),
BackgroundColor3 = Library.Colors.Section,
BorderSizePixel = 0,
TextColor3 = Library.Colors.SectionText,
TextSize = 11,
FontFace = Library.Font,
Text = options.name,
Name = "SectionText"
})
Library:connection(SECTIONTEXT:GetPropertyChangedSignal("TextBounds"), function() SECTIONTEXT.Size = UDim2.new(0,SECTIONTEXT.TextBounds.X + 25,0,10) end)
local ELEMENTCONTAINER = Library:Create("Frame", {
Parent = SECTION,
Size = UDim2.new(1, 0, 1, -10),
Position = UDim2.new(0, 0, 0, 10),
BackgroundTransparency = 1,
Name = "ElementContainer"
})
Library:Create("UIListLayout", { 
Parent = ELEMENTCONTAINER,
SortOrder = Enum.SortOrder.LayoutOrder,
Padding = UDim.new(0, 8)
})
Library:Create("UIPadding", { 
Parent = ELEMENTCONTAINER,
PaddingLeft = UDim.new(0,15),
PaddingRight = UDim.new(0,15),
})
local pos = SECTION.Position.Y.Offset
if options.height == "fill" then
SECTION.Size = UDim2.new(1,0,1,-pos)
elseif options.height == "half" then
SECTION.Size = UDim2.new(1,0,0.5,-pos/2)
end
do 
if getgenv().subtab and options.side == "Right" then
local subtab = options.tab
SECTION.Parent = CONTENTCONTAINER:FindFirstChild(subtab):FindFirstChild("RightContainer")
table.insert(RightHeight[subtab], SECTION.AbsoluteSize.Y)
elseif getgenv().subtab then
local subtab = options.tab
SECTION.Parent = CONTENTCONTAINER:FindFirstChild(subtab):FindFirstChild("LeftContainer")
table.insert(LeftHeight[subtab], SECTION.AbsoluteSize.Y)
end
if options.side == "Right" and not getgenv().subtab then
SECTION.Parent = RIGHTCONTAINER
table.insert(RightHeight,SECTION.AbsoluteSize.Y)
elseif not getgenv().subtab then
SECTION.Parent = LEFTCONTAINER
table.insert(LeftHeight, SECTION.AbsoluteSize.Y)
end
end
Library:Create("UIStroke", { 
Parent = SECTION,
Color = Library.Colors.BorderColor
})
function section:AddButton(options)
options = Library:validate({
name = "button",
callback = function() end,
}, options or {})
local button = {}
local BUTTONCONTAINER = Library:Create("Frame", {
Parent = ELEMENTCONTAINER,
Size = UDim2.new(1, 0, 0, 15),
Name = options.name,
BackgroundTransparency = 1
})
local BUTTON = Library:Create("Frame", {
Parent = BUTTONCONTAINER,
Size = UDim2.new(1, 0, 1, 0),
Position = UDim2.new(0, 0, 0, 0),
Name = "Button",
BackgroundColor3 = Library.Colors.ElementBack,
BorderSizePixel = 1,
BorderColor3 = Library.Colors.BorderColor
})
Library:Create("UIGradient", {
Parent = BUTTON,
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(175, 175, 175)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
},
Rotation = 90,
})
local BUTTONTITLE = Library:Create("TextLabel", {
Parent = BUTTON,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
TextColor3 = Library.Colors.ElementInactive,
TextSize = 11,
Text = options.name,
FontFace = Library.Font,
TextXAlignment = Enum.TextXAlignment.Center,
Name = "ButtonTitle"
})
do 
Library:connection(BUTTON.MouseEnter, function()
Library:tween(BUTTONTITLE, {TextColor3 = Library.Colors.ElementActive})
local input = Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
options.callback()
end
end)
local leave
leave = Library:connection(BUTTON.MouseLeave, function()
input:Disconnect()
leave:Disconnect()
Library:tween(BUTTONTITLE, {TextColor3 = Library.Colors.ElementInactive})
end)
end)
end
return
end
function section:AddTextbox(options)
options = Library:validate({
name = "example textbox",
default = "Test",
callback = function() end,
}, options or {})
local TEXTBOX = Library:Create("Frame", {
Parent = ELEMENTCONTAINER,
Name = "textbox",
BackgroundColor3 = Library.Colors.ElementBack,
BackgroundTransparency = 0,
BorderSizePixel = 1,
BorderColor3 = Library.Colors.BorderColor,
Size = UDim2.new(1, 0, 0, 15),
ZIndex = 10,
})
Library:Create("UIGradient", {
Parent = TEXTBOX,
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(175, 175, 175)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
},
Rotation = 90,
})
local BACKGROUND = Library:Create("Frame", {
Parent = TEXTBOX,
Name = "BACKGROUND",
Position = UDim2.new(0, 0, 0, 0),
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 0,
})
local MAIN = Library:Create("ScrollingFrame", {
Parent = BACKGROUND,
Name = "main",
Active = true,
BackgroundColor3 = Color3.fromRGB(12, 12, 12),
BorderColor3 = Color3.fromRGB(0, 0, 0),
Size = UDim2.new(1, 0, 1, 0),
CanvasSize = UDim2.new(0, 0, 0, 0),
ScrollBarThickness = 0,
})
local BOX = Library:Create("TextBox", {
Name = "box",
Parent = MAIN,
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1.0,
Selectable = false,
Size = UDim2.new(1, 0, 1, 0),
FontFace = Library.Font,
Text = options.default or "",
TextColor3 = Library.Colors.ElementInactive,
TextSize = 11,
TextStrokeTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Center,
ZIndex = 10
})
do 
Library:connection(BOX.MouseEnter, function()
Library:tween(BOX, {TextColor3 = Library.Colors.ElementActive})
end)
Library:connection(BOX.MouseLeave, function()
Library:tween(BOX, {TextColor3 = Library.Colors.ElementInactive})
end)
Library:connection(BOX:GetPropertyChangedSignal("Text"), function()
options.name = BOX.Text
if options.callback then
options.callback(BOX.Text)
end
end)
Library:connection(BOX.FocusLost, function(enterPressed)
local text = BOX.Text
local callback_text = text ~= "" and text or options.default
if options.callback then
options.callback(callback_text)
end
end)
end
return
end
function section:AddToggle(options)
options = Library:validate({
name = "example toggle",
default = false,
risky = false,
callback = function() end,
}, options or {})
local toggle = {
Hover = false,
State = options.default
}
local TOGGLECONTAINER = Library:Create("Frame", {
Size = UDim2.new(1,0,0,14),
Parent = ELEMENTCONTAINER,
BackgroundTransparency = 1,
Name = "ToggleContainer",
})
local TOGGLE = Library:Create("Frame", {
Parent = TOGGLECONTAINER,
Size = UDim2.new(0,9,0,9),
BackgroundColor3 = Library.Colors.ElementBack,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Name = "Toggle",
})
Library:Create("UIGradient", { 
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(175, 175, 175)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
},
Rotation = 90,
Parent = TOGGLE,
})
local TOGGLE_OUTLINE = Library:Create("UIStroke", {
Thickness = 1,
Color = Color3.fromRGB(0, 0, 0),
LineJoinMode = Enum.LineJoinMode.Miter,
Parent = TOGGLE,
Name = "UIStroke",
})
local TOGGLETITLE = Library:Create("TextLabel", {
Parent = TOGGLECONTAINER,
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 20, 0, 7),
BackgroundTransparency = 1,
TextSize = 11,
Text = options.name,
FontFace = Library.Font,
TextXAlignment = Enum.TextXAlignment.Left,
Name = "ToggleTitle",
})
local SUBELEMENTHOLDER = Library:Create("Frame", {
Parent = TOGGLECONTAINER,
Size = UDim2.new(1,-5,1,0),
Position = UDim2.new(0,5,0,0),
BackgroundTransparency = 1,
Name = "elementholder",
})
Library:Create("UIListLayout", {
Parent = SUBELEMENTHOLDER,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Horizontal,
HorizontalAlignment = Enum.HorizontalAlignment.Right,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 10),
Name = "elementlayout",
})
do 
Library:connection(TOGGLE.MouseEnter, function()
Library:tween(TOGGLE_OUTLINE, {Color = Library.Colors.Accent})
local input = Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
toggle.State = not toggle.State
options.callback(toggle.State)
if toggle.State then
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.Accent})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.ElementActive})
else
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.ElementBack})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.ElementInactive})
end
if toggle.State and options.risky then
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.Accent})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.RiskyActive})
elseif options.risky then
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.ElementBack})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.RiskyInactive})
end
end
end)
local leave
leave = Library:connection(TOGGLE.MouseLeave, function()
input:Disconnect()
leave:Disconnect()
Library:tween(TOGGLE_OUTLINE, {Color = Color3.fromRGB(0, 0, 0)})
end)
end)
if toggle.State then
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.Accent})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.ElementActive})
else
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.ElementBack})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.ElementInactive})
end
if toggle.State and options.risky then
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.Accent})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.RiskyActive})
elseif options.risky then
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.ElementBack})
Library:tween(TOGGLETITLE, {TextColor3 = Library.Colors.RiskyInactive})
end
end
options.callback(toggle.State)
function toggle:UpdateState(state, fire)
toggle.State = state and true or false
if toggle.State then
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.Accent})
Library:tween(TOGGLETITLE, {TextColor3 = options.risky and Library.Colors.RiskyActive or Library.Colors.ElementActive})
else
Library:tween(TOGGLE, {BackgroundColor3 = Library.Colors.ElementBack})
Library:tween(TOGGLETITLE, {TextColor3 = options.risky and Library.Colors.RiskyInactive or Library.Colors.ElementInactive})
end
if fire ~= false then
options.callback(toggle.State)
end
end
function toggle:AddKeybind(options)
options = Library:validate({
default = "...",
getkey = function() end,
callback = function() end,
}, options or {})
options.getkey(options.default)
local keybind = {
Hover = false,
Key = nil,
}
local KEYBIND = Library:Create("Frame", {
Parent = SUBELEMENTHOLDER,
Name = "Keybind",
BackgroundColor3 = Library.Colors.ElementBack,
BorderSizePixel = 0
})
local KEYBINDTEXT = Library:Create("TextLabel", {
Parent = KEYBIND,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
TextColor3 = Library.Colors.ElementActive,
TextSize = 11,
Text = options.default,
FontFace = Library.Font,
TextXAlignment = Enum.TextXAlignment.Center,
Name = "KeybindText",
})
Library:Create("UIStroke", {
Thickness = 1,
Color = Color3.fromRGB(0, 0, 0),
LineJoinMode = Enum.LineJoinMode.Miter,
Parent = KEYBIND,
Name = "UIStroke8",
})
KEYBIND.Size = UDim2.new(0, KEYBINDTEXT.TextBounds.X + 12, 0, 12)
do 
Library:connection(KEYBIND.MouseEnter, function()
keybind.Hover = true
Library:tween(KEYBINDTEXT, {TextColor3 = Library.Colors.Accent})
end)
Library:connection(KEYBIND.MouseLeave, function()
keybind.Hover = false
Library:tween(KEYBINDTEXT, {TextColor3 = Library.Colors.ElementActive})
end)
local function _wait_for_input()
local getkey
getkey = Library:connection(_uis.InputBegan, function(input)
local keyPressed = input.KeyCode == Enum.KeyCode.Unknown and input.UserInputType or input.KeyCode
local isDisallowed = false
for _, key in ipairs({Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.UserInputType.MouseMovement}) do
if keyPressed == key then
isDisallowed = true
break
end
end if isDisallowed then return end 
if keyPressed ~= Enum.KeyCode.Backspace then
keybind.Key = keyPressed
options.getkey(keyPressed)
end
local ButtonMap = {
[Enum.UserInputType.MouseButton1] = "Enum.UserInputType.MB1",
[Enum.UserInputType.MouseButton2] = "Enum.UserInputType.MB2",
[Enum.UserInputType.MouseButton3] = "Enum.UserInputType.MB3",
}
if ButtonMap[keyPressed] then keyPressed = ButtonMap[keyPressed] end 
if keyPressed == Enum.KeyCode.Backspace then 
keybind.Key = nil
options.getkey(nil)
KEYBINDTEXT.Text = "..."
Library:tween(KEYBINDTEXT, {TextColor3 = Library.Colors.Accent})
getkey:Disconnect()
else 
local str = tostring(keyPressed)
local _, Index1 = str:find("%.")
local _, Index2 = str:find("%.", Index1 + 1)
if Index2 then
str = str:sub(Index2 + 1)
local formattedkey = str:gsub("Left", "L"):gsub("Right", "R")
KEYBINDTEXT.Text = string.lower(formattedkey)
Library:tween(KEYBINDTEXT, {TextColor3 = Library.Colors.ElementActive})
KEYBIND.Size = UDim2.new(0, KEYBINDTEXT.TextBounds.X + 12, 0, 12)
end
if keyPressed then getkey:Disconnect() end
end
end)
end
Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
if keybind.Hover then
KEYBINDTEXT.Text = "..."
KEYBIND.Size = UDim2.new(0, KEYBINDTEXT.TextBounds.X + 12, 0, 12)
_wait_for_input()
end
end
end)
Library:connection(_uis.InputBegan, function(input, gpe)
if gpe or keybind.Hover or not keybind.Key then return end
local pressed = input.KeyCode == Enum.KeyCode.Unknown and input.UserInputType or input.KeyCode
if pressed == keybind.Key then
options.callback()
end
end)
end
end
function toggle:AddColorpicker(options)
options = Library:validate({
default = Color3.fromRGB(255,255,255),
getcolor = function() end,
gettransparency = function() end
}, options or {})
local ELEMENT = Library:Create("Frame", {
Name = "element",
Parent = SUBELEMENTHOLDER,
Size = UDim2.new(0, 22, 0, 12),
BorderColor3 = Library.Colors.BorderColor,
BorderSizePixel = 1,
})
Library:Create("UIGradient", {
Name = "UIGradient",
Parent = ELEMENT,
Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
}),
Rotation = 90
})
local COLORPICKER = Library:Create("Frame", {
Name = "colorpicker",
Parent = TOGGLECONTAINER,
Size = UDim2.new(0, 200, 0, 200),
Visible = false,
BorderColor3 = Color3.fromRGB(0, 0, 0),
Position = UDim2.new(0, -360, 0, -150),
BorderSizePixel = 2,
BackgroundColor3 = Library.Colors.Window,
})
local BRIGHTNESS = Library:Create("Frame", {
Name = "brightness",
Parent = COLORPICKER,
Size = UDim2.new(1, -20, 1, -20),
BorderColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 2,
})
local IMAGELABEL = Library:Create("ImageLabel", {
Name = "ImageLabel",
Parent = BRIGHTNESS,
Size = UDim2.new(1, 0, 1, 0),
BorderColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
Image = "rbxassetid://2615689005"
})
local PICKER_BRIGHTNESS = Library:Create("ImageLabel", {
Name = "picker",
Parent = BRIGHTNESS,
Size = UDim2.new(0, 10, 0, 10),
BorderColor3 = Color3.fromRGB(0, 0, 0),
BackgroundTransparency = 1,
BorderSizePixel = 2,
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
Image = "rbxassetid://18268646065"
})
local COPY = Library:Create("Frame", {
Parent = COLORPICKER,
BackgroundColor3 = Library.Colors.Window,
Size = UDim2.new(0.5,-1,0,14),
Position = UDim2.new(0,-6,0,-23),
BorderSizePixel = 0
})
local COPYTEXT = Library:Create("TextLabel", {
Parent = COPY,
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
TextColor3 = Color3.fromRGB(255,255,255),
TextSize = 11,
Text = "copy",
FontFace = Library.Font,
TextXAlignment = Enum.TextXAlignment.Center,
BorderSizePixel = 0
})
local PASTE = Library:Create("Frame", {
Parent = COLORPICKER,
BackgroundColor3 = Library.Colors.Window,
Size = UDim2.new(0.5,-1,0,14),
Position = UDim2.new(1,6,0,-23),
AnchorPoint = Vector2.new(1,0),
BorderSizePixel = 0
})
local PASTETEXT = Library:Create("TextBox", {
Parent = PASTE,
BackgroundTransparency = 1,
Size = UDim2.new(1,0,1,0),
BorderSizePixel = 0,
Selectable = false,
FontFace = Library.Font,
TextColor3 = Color3.fromRGB(255,255,255),
TextSize = 11,
TextStrokeTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Center,
})
Library:Create("UIPadding", {
Name = "UIPadding",
Parent = COLORPICKER,
PaddingBottom = UDim.new(0, 5),
PaddingTop = UDim.new(0, 5),
PaddingLeft = UDim.new(0, 5),
PaddingRight = UDim.new(0, 5)
})
local HUE = Library:Create("ImageLabel", {
Name = "hue",
Parent = COLORPICKER,
AnchorPoint = Vector2.new(1, 0),
Size = UDim2.new(0, 15, 1, -20),
BorderColor3 = Color3.fromRGB(0, 0, 0),
Position = UDim2.new(1, 0, 0, 0),
BorderSizePixel = 2,
Image = "rbxassetid://2615692420",
})
local PICKER_HUE = Library:Create("Frame", {
Name = "picker",
Parent = HUE,
Size = UDim2.new(1, 0, 0, 1),
BorderColor3 = Color3.fromRGB(0, 0, 0),
Position = UDim2.new(0, 0, 0, 80),
BackgroundColor3 = Color3.fromRGB(255, 255, 255)
})
local TRANSPARENCY = Library:Create("ImageLabel", {
Name = "transparency",
Parent = COLORPICKER,
AnchorPoint = Vector2.new(0, 1),
Size = UDim2.new(1, -20, 0, 15),
BackgroundTransparency = 1,
BorderColor3 = Color3.fromRGB(0, 0, 0),
Position = UDim2.new(0, 0, 1, 0),
BorderSizePixel = 2,
Image = "rbxassetid://18294288954"
})
local PICKER_TRANSPARENCY = Library:Create("Frame", {
Name = "picker",
Parent = TRANSPARENCY,
Size = UDim2.new(0, 1, 1, 0),
BorderColor3 = Color3.fromRGB(0, 0, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255)
})
local PREVIEW = Library:Create("Frame", {
Name = "preview",
Parent = COLORPICKER,
AnchorPoint = Vector2.new(1, 1),
Size = UDim2.new(0, 15, 0, 15),
BorderColor3 = Color3.fromRGB(0, 0, 0),
Position = UDim2.new(1, 0, 1, 0),
BorderSizePixel = 2,
})
Library:Create("UIGradient", {
Name = "UIGradient",
Parent = PREVIEW,
Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
ColorSequenceKeypoint.new(0.8, Color3.fromRGB(230, 230, 230)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}),
Rotation = 45
})
Library:connection(ELEMENT.MouseEnter, function()
Library:tween(ELEMENT, {BorderColor3 = Library.Colors.Accent})
end)
Library:connection(ELEMENT.MouseLeave, function()
Library:tween(ELEMENT, {BorderColor3 = Color3.fromRGB(0,0,0)})
end)
local elhovered = false
Library:connection(ELEMENT.MouseEnter, function()
elhovered = true
Library:tween(ELEMENT, {BorderColor3 = Library.Colors.Accent})
end)
Library:connection(ELEMENT.MouseLeave, function()
elhovered = false
Library:tween(ELEMENT, {BorderColor3 = Library.Colors.BorderColor})
end)
Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 and elhovered then
for i,v in pairs(SCREENGUI:GetDescendants()) do
if v.Name == "colorpicker" and v.Visible == true and ELEMENT.Parent.Parent.Parent.Parent:FindFirstChild("colorpicker") and button2.Parent.Parent.Parent.Parent:FindFirstChild("colorpicker") ~= v then
v.Visible = false
end
end
COLORPICKER.Visible = not COLORPICKER.Visible
ELEMENT.BorderColor3 = Library.Colors.BorderColor
end
end)
local absvalue
local function updateValue(value, fakevalue)
if typeof(value) == "table" then value = fakevalue end
local r, g, b = value.r * 255, value.g * 255, value.b * 255
options.default = value
ELEMENT.BackgroundColor3 = Color3.fromRGB(r,g,b)
PREVIEW.BackgroundColor3 = Color3.fromRGB(r,g,b)
PASTETEXT.Text = tostring(math.round(r)) .. "," .. tostring(math.round(g)) .. "," .. tostring(math.round(b))
absvalue = tostring(math.round(r)) .. "," .. tostring(math.round(g)) .. "," .. tostring(math.round(b))
options.getcolor(value)
end
local white, black = Color3.new(1,1,1), Color3.new(0,0,0)
local colors = {Color3.new(1,0,0),Color3.new(1,1,0),Color3.new(0,1,0),Color3.new(0,1,1),Color3.new(0,0,1),Color3.new(1,0,1),Color3.new(1,0,0)}
local heartbeat = _runservice.Heartbeat
local brightnessX,brightnessY,hueY = 0,0,0
local oldpercentX,oldpercentY = 0,0
function lerp(startValue, endValue, duration, callback)
local startTime = tick() 
local completed = false
task.spawn(function()
while true do
local currentTime = tick() - startTime
if currentTime >= duration then
callback(endValue)
completed = true
break
end
local progress = currentTime / duration
local lerped = startValue + (endValue - startValue) * (1 - (1 - progress) * (1 - progress))
callback(lerped)
task.wait()
end
end)
while not completed do
task.wait()
end
end
Library:connection(HUE.MouseEnter, function()
local input = Library:connection(HUE.InputBegan, function(key)
if key.UserInputType == Enum.UserInputType.MouseButton1 then
while heartbeat:wait() and _uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
local percent = (hueY-HUE.AbsolutePosition.Y-36)/HUE.AbsoluteSize.Y
local num = math.max(1, math.min(7,math.floor(((percent*7+0.5)*100))/100))
local startC = colors[math.floor(num)]
local endC = colors[math.ceil(num)]
local color = white:lerp(BRIGHTNESS.BackgroundColor3, oldpercentX):lerp(black, oldpercentY)
BRIGHTNESS.BackgroundColor3 = startC:lerp(endC, num-math.floor(num)) or Color3.new(0, 0, 0)
updateValue(color)
lerp(PICKER_HUE.Position.Y.Offset, PICKER_HUE.Parent.AbsoluteSize.Y * percent, 0.1, function(value)
PICKER_HUE.Position = UDim2.new(0,0,0,value)
end)
end
end
end)
local leave
leave = Library:connection(HUE.MouseLeave, function()
input:disconnect()
leave:disconnect()
end)
end)
Library:connection(TRANSPARENCY.MouseEnter, function()
local input = Library:connection(_uis.InputBegan, function(key)
if key.UserInputType == Enum.UserInputType.MouseButton1 then
while heartbeat:wait() and _uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
if mouse.X >= TRANSPARENCY.AbsolutePosition.X and mouse.X <= TRANSPARENCY.AbsolutePosition.X + TRANSPARENCY.AbsoluteSize.X then 
local output = (mouse.X - TRANSPARENCY.AbsolutePosition.X) / TRANSPARENCY.AbsoluteSize.X
local value = math.clamp(output * (1 - 0) + 0, 0, 1)
options.gettransparency(value)
lerp(PICKER_TRANSPARENCY.Position.X.Offset, mouse.X - TRANSPARENCY.AbsolutePosition.X, 0.1, function(value)
PICKER_TRANSPARENCY.Position = UDim2.new(0,value,0,0)
end)
end
end
end
end)
local leave
leave = Library:connection(TRANSPARENCY.MouseLeave, function()
input:disconnect()
leave:disconnect()
end)
end)
local isDragging = false
Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = true end
end)
Library:connection(_uis.InputEnded, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false end
end)
local brightnessEnter
Library:connection(BRIGHTNESS.MouseEnter, function()
brightnessEnter = true
local input = Library:connection(BRIGHTNESS.InputBegan, function(key)
if key.UserInputType == Enum.UserInputType.MouseButton1 then
while heartbeat:wait() and _uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
local xPercent = (brightnessX - BRIGHTNESS.AbsolutePosition.X) / BRIGHTNESS.AbsoluteSize.X
local yPercent = (brightnessY - BRIGHTNESS.AbsolutePosition.Y - 36) / BRIGHTNESS.AbsoluteSize.Y
local color = white:lerp(BRIGHTNESS.BackgroundColor3, xPercent):lerp(black, yPercent)
updateValue(color)
oldpercentX, oldpercentY = xPercent, yPercent
end
end
end)
local leave
leave = Library:connection(BRIGHTNESS.MouseLeave, function()
input:disconnect()
leave:disconnect()
end)
end)
Library:connection(BRIGHTNESS.MouseLeave, function()
brightnessEnter = false
end)
Library:connection(_uis.InputChanged, function(input)
if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
local offsetX = brightnessX - BRIGHTNESS.AbsolutePosition.X
local offsetY = brightnessY - BRIGHTNESS.AbsolutePosition.Y - 35
PICKER_BRIGHTNESS.Position = UDim2.new(0, offsetX, 0, offsetY)
end
end)
Library:connection(HUE.MouseMoved, function(_, y)
hueY = y
end)
Library:connection(HUE.MouseMoved, function(_, y)
hueY = y
end)
Library:connection(BRIGHTNESS.MouseMoved, function(x, y)
if brightnessEnter then
brightnessX,brightnessY = x,y
end
end)
Library:connection(COPY.MouseEnter, function()
Library:tween(COPYTEXT, {TextColor3 = Library.Colors.Accent})
local input = Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
setclipboard(absvalue)
end
end)
local leave
leave = Library:connection(COPY.MouseLeave, function()
Library:tween(COPYTEXT, {TextColor3 = Color3.fromRGB(255,255,255)})
input:Disconnect()
leave:Disconnect()
end)
end)
Library:connection(PASTE.MouseEnter, function()
Library:tween(PASTETEXT, {TextColor3 = Library.Colors.Accent})
local leave
leave = Library:connection(PASTE.MouseLeave, function()
Library:tween(PASTETEXT, {TextColor3 = Color3.fromRGB(255,255,255)})
leave:Disconnect()
end)
end)
Library:connection(PASTETEXT.FocusLost, function(enterPressed)
if enterPressed then
local r, g, b = string.match(PASTETEXT.Text, "(%d+),(%d+),(%d+)")
if r == nil or g == nil or b == nil then return end
local color = Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b))
updateValue(color)
BRIGHTNESS.BackgroundColor3 = color
PASTETEXT.Text = r .. "," .. g .. "," .. b
end
end)
options.default = options.default
updateValue(options.default or Color3.new(1,1,1))
end
return toggle
end
function section:AddSlider(options)
options = Library:validate({
name = "example slider",
default = 50,
suffix = "",
changeby = 5,
min = 0,
max = 100,
callback = function(value) end
}, options or {})
local slider = {
MouseDown = false,
Hover = false,
Connection = nil
}
options.value = 0
if options.min then
if options.default < options.min then
options.default = options.min
end
end
local SLIDERCONTAINER = Library:Create("Frame", {
Size = UDim2.new(1, 0, 0, 20),
Parent = ELEMENTCONTAINER,
BackgroundTransparency = 1,
Name = "SliderContainer"
})
local SLIDERTITLE = Library:Create("TextLabel", {
Parent = SLIDERCONTAINER,
Size = UDim2.new(1, -2, 1, -15),
Position = UDim2.new(0, 2, 0, 0),
BackgroundTransparency = 1,
TextColor3 = Library.Colors.ElementInactive,
TextSize = 11,
Text = options.name,
FontFace = Library.Font,
TextXAlignment = Enum.TextXAlignment.Left,
Name = "SliderTitle"
})
local SLIDERBACK = Library:Create("Frame", {
Parent = SLIDERCONTAINER,
Size = UDim2.new(1, 0, 0, 6),
AnchorPoint = Vector2.new(0, 1),
Position = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(25, 25, 25),
BorderSizePixel = 0,
Name = "SliderBack",
})
Library:Create("UIStroke", {
Parent = SLIDERBACK,
Thickness = 1,
Color = Color3.fromRGB(0, 0, 0),
LineJoinMode = Enum.LineJoinMode.Miter,
Name = "UIStrokeBackSlider"
})
Library:Create("UICorner", {
Parent = SLIDERBACK,
CornerRadius = UDim.new(0, 4)
})
local SLIDER = Library:Create("Frame", {
Parent = SLIDERBACK,
Size = UDim2.new(1, -80, 1, 0),
Name = "Slider",
ZIndex = 1,
BorderSizePixel = 0
})
Library:Create("UIGradient", {
Parent = SLIDER,
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.00, Library.Colors.Accent),
ColorSequenceKeypoint.new(1.00, Color3.fromRGB(27, 27, 55))
},
Rotation = 90,
})
local SLIDERVALUE = Library:Create("TextLabel", {
Size = UDim2.new(0, 10, 0, 10),
Parent = SLIDER,
TextXAlignment = Enum.TextXAlignment.Center,
Position = UDim2.new(1, -10, 0, 5),
BackgroundTransparency = 1,
TextColor3 = Library.Colors.ElementInactive,
FontFace = Library.Font,
Text = math.round(options.value),
TextTransparency = 1,
TextSize = 10,
Name = options.name
})
Library:Create("UIStroke", {
Thickness = 1,
Color = Color3.new(0, 0, 0),
Parent = SLIDERVALUE
})
function slider:SetValue(v)
if v == nil then
local output = (mouse.X - SLIDERBACK.AbsolutePosition.X) / SLIDERBACK.AbsoluteSize.X
local slidervalue = math.clamp(math.round(output * (options.max - options.min) + options.min), options.min, options.max)
SLIDERVALUE.Text = slidervalue.. (options.suffix or "")
SLIDER:TweenSize(UDim2.fromScale((slidervalue - options.min) / (options.max - options.min), 1), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.1, true)
else
SLIDERVALUE.Text = v.. (options.suffix or "")
SLIDER:TweenSize(UDim2.fromScale((v - options.min) / (options.max - options.min), 1), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.1, true)
end
options.callback(slider:GetValue())
end
function slider:GetValue()
local value = tonumber(SLIDERVALUE.Text)
if options.suffix then
local suffixLength = string.len(options.suffix)
return tonumber(string.sub(SLIDERVALUE.Text, 1, -suffixLength - 1))
else
return value
end
end
SLIDER.Size = UDim2.fromScale((options.default - options.min) / (options.max - options.min), 1)
SLIDERVALUE.Text = options.default.. (options.suffix or "")
do 
Library:connection(SLIDERBACK.MouseEnter, function()
Library:tween(SLIDERVALUE, {TextTransparency = 0})
Library:tween(SLIDERTITLE, {TextColor3 = Library.Colors.ElementActive})
local input = Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
Library:tween(SLIDERVALUE, {TextColor3 = Library.Colors.Accent})
Library:tween(SLIDERVALUE, {TextTransparency = 0})
if not slider.Connection then slider.Connection = _runservice.RenderStepped:Connect(function() slider:SetValue() end) end
end
end)
local leave
leave = Library:connection(SLIDERBACK.MouseLeave, function()
input:Disconnect()
leave:Disconnect()
Library:tween(SLIDERVALUE, {TextTransparency = 1})
Library:tween(SLIDERTITLE, {TextColor3 = Library.Colors.ElementInactive})
end)
end)
Library:connection(_uis.InputEnded, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
slider.Hover = false
Library:tween(SLIDERVALUE, {TextColor3 = Library.Colors.ElementActive})
if slider.Connection then
slider.Connection:Disconnect()
end
slider.Connection = nil
end
end)
end
options.callback(slider:GetValue())
return slider
end
function section:AddDropdown(options)
options = Library:validate({
name = "example dropdown",
list = {"example 1", "example 2", "example 3", "example 4"},
min = 1,
max = 3,
default = 1,
callback = function(active) end
}, options or {})
options.default = options.default or 1
dropdownindex = dropdownindex - 1
local dropdown = {
Hover = false,
active = {options.list[options.default]},
state = false
}
local DROPDOWNCONTAINER = Library:Create("Frame", {
Parent = ELEMENTCONTAINER,
Size = UDim2.new(1, 0, 0, 30),
Name = options.name,
BorderSizePixel = 0,
BackgroundTransparency = 1,
})
local DROPDOWNTEXT = Library:Create("TextLabel", {
Size = UDim2.new(1,0,1,-20),
Parent = DROPDOWNCONTAINER,
Position = UDim2.new(0, 2, 0, -1),
BackgroundTransparency = 1,
TextXAlignment = Enum.TextXAlignment.Left,
FontFace = Library.Font,
Text = options.name,
TextColor3 = Library.Colors.ElementActive,
TextSize = 11,
Name = options.name
})
local ACTIVECHOICE = Library:Create("Frame", {
Size = UDim2.new(1,0,0,15),
AnchorPoint = Vector2.new(0.5, 0),
Position = UDim2.new(0.5, 0, 0, 13),
Parent = DROPDOWNCONTAINER,
BorderSizePixel = 1,
BackgroundColor3 = Library.Colors.ElementBack,
BorderColor3 = Library.Colors.BorderColor,
Name = "ActiveChoice",
ZIndex = dropdownindex + 5
})
Library:Create("UIGradient", { 
Parent = ACTIVECHOICE,
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(175, 175, 175)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
},
Rotation = 90,
})
local ACTIVETEXT = Library:Create("TextLabel", {
Size = UDim2.new(1,0,0,0),
Parent = ACTIVECHOICE,
Position = UDim2.new(0.5, 0, 0, 8),
AnchorPoint = Vector2.new(0.5, 0),
BackgroundTransparency = 1,
TextXAlignment = Enum.TextXAlignment.Center,
FontFace = Library.Font,
Text = "Active",
TextColor3 = Library.Colors.ElementInactive,
TextSize = 11,
Name = "DropdownText",
ZIndex = dropdownindex + 5,
})
dropdown.ActiveTextLabel = ACTIVETEXT
local CHOICEHOLDER = Library:Create("ScrollingFrame", {
Size = UDim2.new(1, -1, 0, 0),
CanvasSize = UDim2.new(0,0,10,0),
Position = UDim2.new(0, 0, 0, 14),
Parent = ACTIVECHOICE,
BackgroundTransparency = 1,
ScrollBarThickness = 0,
Visible = true,
BorderSizePixel = 0,
ZIndex = dropdownindex + 5,
})
Library:Create("UIListLayout", {
Parent = CHOICEHOLDER,
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Vertical,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
Padding = UDim.new(0, 0),
Name = "ChoiceLayout",
})
function dropdown:AddChoice(name)
-- skip duplicates
for _, child in ipairs(CHOICEHOLDER:GetChildren()) do
if child:IsA("Frame") then
local label = child:FindFirstChildWhichIsA("TextLabel")
if label and label.Text == name then
return
end
end
end
-- remove placeholder
for _, child in ipairs(CHOICEHOLDER:GetChildren()) do
if child:IsA("Frame") then
local label = child:FindFirstChildWhichIsA("TextLabel")
if label and label.Text == "(none)" then
child:Destroy()
for i = #dropdown.active, 1, -1 do
if dropdown.active[i] == "(none)" then
table.remove(dropdown.active, i)
end
end
end
end
end
local choice = {
Name = name,
Hover = false,
state = false
}
if dropdown.active == choice.Name then
choice.state = true
end
local CHOICE = Library:Create("Frame", {
Size = UDim2.new(1,-2,0,15),
Parent = CHOICEHOLDER,
AnchorPoint = Vector2.new(0.5,0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ZIndex = 10,
})
local CHOICETEXT = Library:Create("TextLabel", {
Size = UDim2.new(1,0,1,0),
Parent = CHOICE,
AnchorPoint = Vector2.new(0.5,0),
Position = UDim2.new(0.5, 0, 0, 0),
BackgroundTransparency = 1,
FontFace = Library.Font,
Text = name,
TextColor3 = Library.Colors.ElementInactive,
TextSize = 10,
Name = name,
ZIndex = dropdownindex + 5,
})
local CHOICEBAR = Library:Create("Frame", {
Parent = CHOICE,
Size = UDim2.new(0,0,0,1),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.5, 5),
BackgroundTransparency = 0.5,
BackgroundColor3 = Library.Colors.Accent,
ZIndex = dropdownindex + 5,
})
for i, name in ipairs(dropdown.active) do
if name == choice.Name then
choice.state = true
ACTIVETEXT.Text = table.concat(dropdown.active, ", ")
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.Accent})
Library:tween(CHOICEBAR, {BackgroundTransparency = 0.5})
Library:tween(CHOICEBAR, {Size = UDim2.new(0,25,0,1)})
options.callback(ACTIVETEXT.Text)
break
end
end
do
Library:connection(CHOICE.MouseEnter, function()
if choice.state ~= true then
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.ElementActive})
Library:tween(CHOICEBAR, {Size = UDim2.new(0,25,0,1)})
end
local input = Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
local count = 0
for _, v in ipairs(dropdown.active) do
count = count + 1
end
if choice.state == false and count < options.max then
choice.state = not choice.state
if choice.state == true then
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.ElementActive})
Library:tween(CHOICEBAR, {BackgroundTransparency = 0.5})
table.insert(dropdown.active, choice.Name)
ACTIVETEXT.Text = table.concat(dropdown.active, ", ")
options.callback(ACTIVETEXT.Text)
else
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.ElementInactive})
Library:tween(CHOICEBAR, {BackgroundTransparency = 1})
for i, name in ipairs(dropdown.active) do
if name == choice.Name then
table.remove(dropdown.active, i)
ACTIVETEXT.Text = table.concat(dropdown.active, ", ")
options.callback(ACTIVETEXT.Text)
break
end
end
end
elseif choice.state == true and count > options.min then
choice.state = not choice.state
if choice.state then Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.ElementActive}) end
for i, name in ipairs(dropdown.active) do
if name == choice.Name then
table.remove(dropdown.active, i)
ACTIVETEXT.Text = table.concat(dropdown.active, ", ")
options.callback(ACTIVETEXT.Text)
break
end
end
end
end
end)
local leave
leave = Library:connection(CHOICE.MouseLeave, function()
if choice.state ~= true then
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.ElementInactive})
Library:tween(CHOICEBAR, {Size = UDim2.new(0,0,0,1)})
end
input:Disconnect()
leave:Disconnect()
end)
end)
end
dropdown:UpdateSize()
end
function dropdown:UpdateSize()
local endsize = 0
for _, choice in ipairs(CHOICEHOLDER:GetChildren()) do
if choice:IsA("Frame") then
endsize = endsize + 15
end
end
if endsize > 100 then endsize = 100 end
if endsize < 15 then endsize = 15 end
dropdown.endsize = endsize
if dropdown.state then
ACTIVECHOICE.Size = UDim2.new(1,0,1,endsize - 13)
CHOICEHOLDER.Size = UDim2.new(1,-1,0,endsize - 2)
end
end
for _,v in pairs(options.list) do
dropdown:AddChoice(v)
end
do
dropdown:UpdateSize()
local Cholderhovered
Library:connection(CHOICEHOLDER.MouseEnter, function()
Cholderhovered = true
local leave
leave = Library:connection(CHOICEHOLDER.MouseLeave, function()
leave:Disconnect()
Cholderhovered = false
end)
end)
Library:connection(ACTIVECHOICE.MouseEnter, function()
if dropdown.state ~= true then Library:tween(ACTIVETEXT, {TextColor3 = Library.Colors.ElementActive}) end
local input = Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 and not Cholderhovered then
dropdown.state = not dropdown.state
local endsize = dropdown.endsize or 15
if dropdown.state then
Library:tween(ACTIVETEXT, {TextColor3 = Library.Colors.ElementActive})
Library:tween(ACTIVECHOICE, {Size = UDim2.new(1,0,1,endsize - 13)})
Library:tween(CHOICEHOLDER, {Size = UDim2.new(1,-1,0,endsize - 2)})
else
Library:tween(ACTIVETEXT, {TextColor3 = Library.Colors.ElementInactive})
Library:tween(ACTIVECHOICE, {Size = UDim2.new(1,0,0,15)})
Library:tween(CHOICEHOLDER, {Size = UDim2.new(1,-1, 0,0)})
end
end
end)
local leave
leave = Library:connection(ACTIVECHOICE.MouseLeave, function()
input:Disconnect()
leave:Disconnect()
if dropdown.state ~= true then
Library:tween(ACTIVETEXT, {TextColor3 = Library.Colors.ElementInactive})
end
end)
end)
end
return dropdown
end
function section:AddList(options)
options = Library:validate({
default = 1,
list = {"example 1", "example 2", "example 3", "example 4", "example 5", "example 6", "example 7", "example 8", "example 9", "example 10"},
callback = function(active) end
}, options or {})
options.default = options.default or 1
local List = {
CurrentChoice = nil
}
local LISTCONTAINER = Library:Create("Frame", {
Parent = ELEMENTCONTAINER,
Size = UDim2.new(1, 0, 0, 100),
Name = options.name,
BorderSizePixel = 1,
BorderColor3 = Color3.fromRGB(255,255,255),
BackgroundTransparency = 0,
})
Library:Create("UIGradient", {
Parent = LISTCONTAINER,
Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 74, 88)),
ColorSequenceKeypoint.new(1, Library.Colors.ElementBack)
},
Rotation = 90,
})
local CHOICEHOLDER = Library:Create("ScrollingFrame", {
Parent = LISTCONTAINER,
Size = UDim2.new(1,0,1,0),
CanvasSize = UDim2.new(0,0,10,0),
BackgroundTransparency = 1,
ScrollBarThickness = 0,
})
Library:Create("UIListLayout", {
Parent = CHOICEHOLDER,
FillDirection = Enum.FillDirection.Vertical,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 4),
SortOrder = Enum.SortOrder.LayoutOrder,
Name = "ListLayout"
})
local TRANSPARENCYEFFECT = Library:Create("Frame",{
Parent = LISTCONTAINER,
Size = UDim2.new(1,0,1,0),
BackgroundColor3 = Color3.fromRGB(0,0,0),
BorderSizePixel = 0,
ZIndex = 2,
})
Library:Create("UIGradient", {
Parent = TRANSPARENCYEFFECT,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(0.8, 0.6),
NumberSequenceKeypoint.new(1, 0),
}),
Rotation = 90
})
Library:connection(CHOICEHOLDER.MouseEnter, function()
List.MouseInside = true
end)
Library:connection(CHOICEHOLDER.MouseLeave, function()
List.MouseInside = false
end)
function List:AddChoice(name)
local CHOICE = Library:Create("Frame", {
Size = UDim2.new(1,-2,0,15),
Parent = CHOICEHOLDER,
AnchorPoint = Vector2.new(0.5,0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ZIndex = 100,
})
local CHOICETEXT = Library:Create("TextLabel", {
Size = UDim2.new(1,0,1,0),
Parent = CHOICE,
AnchorPoint = Vector2.new(0.5,0),
Position = UDim2.new(0.5, 0, 0, 0),
BackgroundTransparency = 1,
FontFace = Library.Font,
Text = name,
TextColor3 = Library.Colors.ElementInactive,
TextSize = 10,
Name = name,
})
local CHOICEBAR = Library:Create("Frame", {
Parent = CHOICE,
Size = UDim2.new(0,0,0,1),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.5, 5),
BackgroundTransparency = 0.5,
BackgroundColor3 = Library.Colors.Accent,
BorderSizePixel = 0
})
do 
local choice = {
Name = name,
Hover = false,
Active = false,
}
if List[default] == choice.Name then choice.Active = true end
Library:connection(CHOICE.MouseEnter, function()
if List.CurrentChoice ~= choice.Name then
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.Accent})
Library:tween(CHOICEBAR, {Size = UDim2.new(0,35,0,1)})
end
choice.Hover = true
end)
Library:connection(CHOICE.MouseLeave, function()
if List.CurrentChoice ~= choice.Name then
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.ElementInactive})
Library:tween(CHOICEBAR, {Size = UDim2.new(0,0,0,1)})
end
choice.Hover = false
end)
Library:connection(_uis.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
if choice.Hover then
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.Accent})
Library:tween(CHOICEBAR, {Size = UDim2.new(0,35,0,1)})
List.CurrentChoice = choice.Name
options.callback(choice.Name)
elseif List.MouseInside then
Library:tween(CHOICETEXT, {TextColor3 = Library.Colors.ElementInactive})
Library:tween(CHOICEBAR, {Size = UDim2.new(0,0,0,1)})
end
end
end)
end
end 
for _,v in pairs(options.list) do
List:AddChoice(v)
end
return section
end
return section
end
return tab
end
do 
_uis.MouseIconEnabled = false
Library:connection(_uis.InputBegan, function(input)
if input.KeyCode == Library.Ui_Bind then
SCREENGUI.Enabled = not SCREENGUI.Enabled
_uis.MouseIconEnabled = not SCREENGUI.Enabled
end
end)
Library:connection(_uis.InputBegan, function(input)
if input.KeyCode == Enum.KeyCode.Delete then
if getgenv()._SalboCleanup then
getgenv()._SalboCleanup()
else
Library:unload()
end
end
end)
end
do 
local CURSOR = Library:Create("ImageLabel", {
Size = UDim2.new(0, 18, 0, 18),
BackgroundTransparency = 1,
ImageColor3 = Library.Colors.Accent,
Image = "rbxassetid://17404277477",
ZIndex = 100,
Parent = SCREENGUI,
})
Library:connection(_runservice.RenderStepped, function() CURSOR.Position = UDim2.new(0, mouse.X -6, 0, mouse.Y - 2) end)
end
do 
local container = {
Hover = false
}
local dragStart, startPos, dragging
Library:connection(INNERCONTAINER.MouseLeave, function()
container.Hover = false
local input = Library:connection(WINDOW.InputBegan, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = WINDOW.Position
end
end)
local enter
enter = Library:connection(INNERCONTAINER.MouseEnter, function()
input:Disconnect()
enter:Disconnect()
container.Hover = true
end)
end)
Library:connection(_uis.InputChanged, function(input)
if container.Hover ~= true then
if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
local delta = input.Position - dragStart
local newX = startPos.X.Offset + delta.X
local newY = startPos.Y.Offset + delta.Y
WINDOW.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
end
end
end)
Library:connection(_uis.InputEnded, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)
end
menu.Window = WINDOW
menu.ScreenGui = SCREENGUI
return menu
end
getgenv()._OdysseyUnload = function()
Library:unload()
end
return AddWindow

end)()

Services.HttpService = game:GetService("HttpService")

local folder_name = "MVSD"

Core.Features.KillAll = {
	Enabled = false
}

Core.Features.AutoShoot = {
	Enabled = false,
}

Core.Features.SilentAim = {
	Enabled = false,
	Range = 300,
	WallCheck = true,
	Priority = "Camera",
	Hook = nil
}

Core.Features.KnifeAura = {
	Enabled = false,
}

Core.Features.SetCooldown = {
	Enabled = false,
	Cooldown = 2.5,
}

Core.Features.SetThrowSpeed = {
	Enabled = false,
	Speed = 150,
}

Core.Features.HitboxExtender = {
	Enabled = false,
	Size = 50,
	Transparency = 0.5
}

Core.Features.CrashAll = {
	Enabled = false,
}

Core.Features.AntiCrash = {
	Enabled = false,
}

Core.Features.NoFog = {
	Enabled = false,
	Density = 0,
	Haze = 0,
	Glare = 0,
	Original = nil,
}

Core.Features.Flight = {
	Enabled = false,
	VerticalSpeed = 50,
	HorizontalSpeed = 50
}

Core.Features.Walkspeed = {
	Enabled = false,
	Speed = 50
}

Core.Features.FOV = {
	Enabled = false,
	Value = 70
}

Core.Features.Gravity = {
	Enabled = false,
	Value = 196.2
}

Core.Features.JumpPower = {
	Enabled = false,
	Power = 50
}

Core.Features.Phase = {
	Enabled = false,
	OriginalCollision = {}
}

Core.Features.LongJump = {
	Enabled = false,
	Height = 50,
	Boost = 50
}

Core.Features.WallClimb = {
	Enabled = false,
	Speed = 50
}

Core.Features.SpinBot = {
	Enabled = false,
	Speed = 50
}

Core.Features.BunnyHop = {
	Enabled = false,
	Speed = 50
}

Core.Features.PlayerESP = {
	Enabled = false,
	TeamCheck = false,
	RemoveHiddenCharacters = false,
	Box = false,
	Tracer = false,
	Skeleton = false,
	Arrows = false,
	Name = false,
	Rainbow = false,
	DefaultColor = Color3.fromRGB(255, 255, 255),
	MaxDistance = 1000
}

Core.Settings = {
	AutoQueue = false,
	AutoReexec = true,
	ScriptPath = "살보결 hub.lua",
	ScriptUrl = "https://raw.githubusercontent.com/deltosh/test/refs/heads/main/d.lua", -- hardcoded reexec source (UI hidden)
	SettingsFile = "MVSD/settings.json",
}

Core.Features.Aura = {
	Enabled = false,
}

Core.Features.SkinChanger = {
	UserId = "",
	ActiveId = nil,
	Saved = {},
	Applying = false,
	SaveFile = "MVSD/skins.json",
}


function Core:GetCharacter(player)
	player = player or LocalPlayer

	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not root or not humanoid then return end

	return character, humanoid, root
end

function Core:CanShoot()
	local player_gui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer.PlayerGui
	if not player_gui then return true end

	local round_countdown = player_gui:FindFirstChild("RoundCountdown")
	if not round_countdown or round_countdown.Enabled == false then
		return true
	end

	local countdown_frame = round_countdown:FindFirstChild("CountdownFrame")
	if not countdown_frame then return true end
	-- 카운트다운 UI가 안 보이면 이미 라운드 시작 → 사격 허용 (Enabled만 남은 오탐 방지)
	if countdown_frame:IsA("GuiObject") and not countdown_frame.Visible then
		return true
	end

	local frame = countdown_frame:FindFirstChild("Frame")
	if not frame then return true end
	if frame:IsA("GuiObject") and not frame.Visible then
		return true
	end

	local number = frame:FindFirstChild("Number")
	if not number or not number.Text then return true end
	if number:IsA("GuiObject") and not number.Visible then
		return true
	end

	local value = tonumber(number.Text)
	if not value then return true end

	return value <= 2
end

function Core:HasLineOfSight(origin, target_character, target_part)
	if not origin or not target_character or not target_part then
		return false
	end

	local character = LocalPlayer.Character
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { character }
	params.IgnoreWater = true

	local direction = target_part.Position - origin
	if direction.Magnitude <= 0 then
		return true
	end

	local result = workspace:Raycast(origin, direction, params)
	if not result then
		return true
	end

	return result.Instance:IsDescendantOf(target_character)
end

function Core:GetAutoShootTarget()
	local character = LocalPlayer.Character
	if not character then return end

	local my_root = character:FindFirstChild("HumanoidRootPart")
	if not my_root then return end

	local origin = Camera.CFrame.Position
	local head = character:FindFirstChild("Head")
	if head then
		origin = head.Position
	end

	local best_head = nil
	local best_dist = math.huge
	local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

	for _, target in next, Services.Players:GetPlayers() do
		if target == LocalPlayer then continue end
		if target:GetAttribute("Match") ~= LocalPlayer:GetAttribute("Match") then continue end

		
		if LocalPlayer.Team and target.Team and target.Team == LocalPlayer.Team then
			continue
		end

		local target_character = target.Character
		if not target_character then continue end

		local humanoid = target_character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then continue end

		local target_head = target_character:FindFirstChild("Head")
		if not target_head then continue end

		local screen_pos, on_screen = Camera:WorldToViewportPoint(target_head.Position)
		if not on_screen or screen_pos.Z <= 0 then continue end

		if not Core:HasLineOfSight(origin, target_character, target_head) then
			continue
		end

		local dist = (Vector2.new(screen_pos.X, screen_pos.Y) - center).Magnitude
		if dist < best_dist then
			best_dist = dist
			best_head = target_head
		end
	end

	return best_head
end

function Core:GetClosest(values)
	local closest_target = nil
	local shortest = math.huge

	local character = LocalPlayer.Character
	if not character then return end

	local humanoid_root_part = character.FindFirstChild(character, "HumanoidRootPart")
	if not humanoid_root_part then return end

	for _, target in next, Services.Players.GetPlayers(Services.Players) do
		if target == LocalPlayer then continue end

		local target_character = target.Character
		if not target_character then continue end

		if target.GetAttribute(target, "Match") ~= LocalPlayer.GetAttribute(LocalPlayer, "Match") then continue end

		if LocalPlayer.Team and target.Team and target.Team == LocalPlayer.Team then continue end

		local target_humanoid_root_part = target_character.FindFirstChild(target_character, "HumanoidRootPart")
		if not target_humanoid_root_part then continue end

		local target_humanoid = target_character.FindFirstChild(target_character, "Humanoid")
		if not target_humanoid then continue end

		if target_humanoid.Health <= 0 then continue end

		local world_distance = (humanoid_root_part.Position - target_humanoid_root_part.Position).Magnitude
		if world_distance > values.range then
			continue
		end

		if values.wall_check then
			local raycast_parameters = RaycastParams.new()
			raycast_parameters.FilterDescendantsInstances = {character}
			raycast_parameters.FilterType = Enum.RaycastFilterType.Exclude

			local direction = target_humanoid_root_part.Position - humanoid_root_part.Position
			local raycast_result = workspace.Raycast(workspace, humanoid_root_part.Position, direction, raycast_parameters)

			if raycast_result and raycast_result.Instance and not raycast_result.Instance.IsDescendantOf(raycast_result.Instance, target_character) then
				continue
			end
		end

		local distance
		if values.priority == "Camera" then
			local screen_position, on_screen = Camera.WorldToViewportPoint(Camera, target_humanoid_root_part.Position)
			if not on_screen then
				continue
			end

			distance = (Vector2.new(screen_position.X, screen_position.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
		else
			distance = world_distance
		end

		if distance < shortest then
			shortest = distance
			closest_target = target_character
		end
	end
	
	return closest_target
end

function Core:GetParts(player)
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local humanoid_root_part = character:FindFirstChild("HumanoidRootPart")
	if not humanoid_root_part then return end

	return character, humanoid, humanoid_root_part
end

function Core:EnsureConfigFolder()
	if typeof(makefolder) ~= "function" or typeof(writefile) ~= "function" then
		return false, "executor missing file API"
	end
	if not isfolder("MVSD") then
		makefolder("MVSD")
	end
	return true
end

function Core:SaveSettings()
	if typeof(writefile) ~= "function" then return false end
	pcall(function()
		Core:EnsureConfigFolder()
	end)
	local payload = {
		AutoQueue = Core.Settings.AutoQueue and true or false,
		AutoReexec = Core.Settings.AutoReexec and true or false,
		ScriptPath = tostring(Core.Settings.ScriptPath or "살보결 hub.lua"),
		ScriptUrl = tostring(Core.Settings.ScriptUrl or ""),
	}
	local ok, encoded = pcall(function()
		return Services.HttpService:JSONEncode(payload)
	end)
	if not ok then return false end
	return pcall(writefile, Core.Settings.SettingsFile, encoded)
end

function Core:LoadSettings()
	if typeof(isfile) ~= "function" or typeof(readfile) ~= "function" then return false end
	if not isfile(Core.Settings.SettingsFile) then return false end
	local ok, raw = pcall(readfile, Core.Settings.SettingsFile)
	if not ok then return false end
	local decode_ok, data = pcall(function()
		return Services.HttpService:JSONDecode(raw)
	end)
	if not decode_ok or type(data) ~= "table" then return false end
	if data.AutoQueue ~= nil then Core.Settings.AutoQueue = data.AutoQueue and true or false end
	if data.AutoReexec ~= nil then Core.Settings.AutoReexec = data.AutoReexec and true or false end
	if data.ScriptPath ~= nil then Core.Settings.ScriptPath = tostring(data.ScriptPath) end
	if data.ScriptUrl ~= nil and tostring(data.ScriptUrl) ~= "" then
		Core.Settings.ScriptUrl = tostring(data.ScriptUrl)
	end
	return true
end

pcall(function()
	Core:LoadSettings()
end)

local function bindKey(toggle)
	toggle:AddKeybind({
		callback = function()
			toggle:UpdateState(not toggle.State)
		end,
	})
end

local NotifyGui = nil
local function Notify(title, message, duration)
	duration = duration or 2.5
	local coreGui = game:GetService("CoreGui")
	local tweenService = game:GetService("TweenService")

	if not NotifyGui or not NotifyGui.Parent then
		NotifyGui = Instance.new("ScreenGui")
		NotifyGui.Name = "SalboNotify"
		NotifyGui.ResetOnSpawn = false
		NotifyGui.IgnoreGuiInset = true
		NotifyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		pcall(function()
			NotifyGui.Parent = coreGui
		end)
		if not NotifyGui.Parent then
			NotifyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
		end
	end

	local frame = Instance.new("Frame")
	frame.Name = "Toast"
	frame.AnchorPoint = Vector2.new(1, 0.5)
	frame.Position = UDim2.new(1, 20, 0.5, 0)
	frame.Size = UDim2.new(0, 220, 0, 54)
	frame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
	frame.BorderSizePixel = 0
	frame.Parent = NotifyGui

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(139, 158, 252)
	stroke.Thickness = 1
	stroke.Parent = frame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.BackgroundTransparency = 1
	titleLabel.Position = UDim2.new(0, 12, 0, 8)
	titleLabel.Size = UDim2.new(1, -24, 0, 18)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 13
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextColor3 = Color3.fromRGB(139, 158, 252)
	titleLabel.Text = title or "살보결"
	titleLabel.Parent = frame

	local msgLabel = Instance.new("TextLabel")
	msgLabel.BackgroundTransparency = 1
	msgLabel.Position = UDim2.new(0, 12, 0, 28)
	msgLabel.Size = UDim2.new(1, -24, 0, 18)
	msgLabel.Font = Enum.Font.Gotham
	msgLabel.TextSize = 12
	msgLabel.TextXAlignment = Enum.TextXAlignment.Left
	msgLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
	msgLabel.Text = message or ""
	msgLabel.Parent = frame

	tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -16, 0.5, 0),
	}):Play()

	task.delay(duration, function()
		local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 20, 0.5, 0),
		})
		tween:Play()
		tween.Completed:Wait()
		frame:Destroy()
	end)
end

local window = AddWindow({
	name = string.format('살보결 <font color="rgb(139, 158, 252)">[v%s]</font>', Core.Version),
	size = UDim2.new(0, 625, 0, 480),
})
Core.HubWindow = window.Window
Core.HubScreenGui = window.ScreenGui

local tabs = {
	Combat = window:AddTab({ name = "combat" }),
	World = window:AddTab({ name = "world" }),
	Mobility = window:AddTab({ name = "mobility" }),
	Render = window:AddTab({ name = "render" }),
	Skins = window:AddTab({ name = "skins" }),
	Settings = window:AddTab({ name = "settings" }),
}

local sections = {
	combat_left = tabs.Combat:AddSection({ name = "aim", side = "Left", height = "fill" }),
	combat_right = tabs.Combat:AddSection({ name = "misc", side = "Right", height = "fill" }),
	world_left = tabs.World:AddSection({ name = "world", side = "Left", height = "fill" }),
	mobility_left = tabs.Mobility:AddSection({ name = "movement", side = "Left", height = "fill" }),
	mobility_right = tabs.Mobility:AddSection({ name = "utility", side = "Right", height = "fill" }),
	render_left = tabs.Render:AddSection({ name = "esp", side = "Left", height = "fill" }),
	render_right = tabs.Render:AddSection({ name = "aura", side = "Right", height = "fill" }),
	skins_left = tabs.Skins:AddSection({ name = "skin changer", side = "Left", height = "fill" }),
	settings_right = tabs.Settings:AddSection({ name = "auto", side = "Left", height = "fill" }),
}

local ConfigSliders = {}
local function trackSlider(key, slider)
	ConfigSliders[key] = slider
	return slider
end

local function getRayOrigin(character)
	local head = character:FindFirstChild("Head")
	if head then
		return head.Position
	end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	return hrp and hrp.Position
end

local function disconnectFeature(name)
	local conn = Core.Connections[name]
	if conn then
		pcall(function()
			conn:Disconnect()
		end)
		Core.Connections[name] = nil
	end
end

-- UI 밝게 하기 직전 버전 (Cursor history FzyG.lua)
KillAll = sections.combat_left:AddToggle({
	name = "Kill All",
	default = Core.Features.KillAll.Enabled,
	callback = function(enabled)
		Core.Features.KillAll.Enabled = enabled
		
		if enabled then
			local shot = false
			local shoot_time = 0
			local delay = 6

			-- 리스폰/새 라운드마다 첫 버스트 다시 가능하게
			local function resetBurst()
				shot = false
				shoot_time = 0
			end
			pcall(function()
				if Core.Connections.KillAllChar then
					Core.Connections.KillAllChar:Disconnect()
				end
			end)
			Core.Connections.KillAllChar = LocalPlayer.CharacterAdded:Connect(resetBurst)
			pcall(function()
				if Core.Connections.KillAllMatch then
					Core.Connections.KillAllMatch:Disconnect()
				end
			end)
			Core.Connections.KillAllMatch = LocalPlayer:GetAttributeChangedSignal("Match"):Connect(resetBurst)

			Core.Connections.KillAll = Services.RunService.PreRender:Connect(function()
				local now = tick()

				for _, target in next, Services.Players:GetPlayers() do
					if target == LocalPlayer then continue end
					-- Team nil==nil 스킵 방지 (듀얼에서 팀이 비어 있을 때)
					if LocalPlayer.Team and target.Team and target.Team == LocalPlayer.Team then continue end
					local myMatch = LocalPlayer:GetAttribute("Match")
					local theirMatch = target:GetAttribute("Match")
					if myMatch ~= nil and theirMatch ~= nil and myMatch ~= theirMatch then continue end

					local character = LocalPlayer.Character
					if not character then continue end

					local player_humanoid_root_part = character:FindFirstChild("HumanoidRootPart")
					if not player_humanoid_root_part then continue end

					local player_humanoid = character:FindFirstChild("Humanoid")
					if not player_humanoid or player_humanoid.Health <= 0 then continue end

					local target_character = target.Character
					if not target_character then continue end

					local humanoid = target_character:FindFirstChild("Humanoid")
					if not humanoid or humanoid.Health <= 0 then continue end

					local humanoid_root_part = target_character:FindFirstChild("HumanoidRootPart")
					if not humanoid_root_part then continue end

					local backpack = LocalPlayer.Backpack
					if not backpack then continue end

					local remotes = Services.ReplicatedStorage:FindFirstChild("Remotes")
					if not remotes then continue end

					local shoot_gun = remotes:FindFirstChild("ShootGun")
					if not shoot_gun then continue end
					
					for _, gun in next, backpack:GetChildren() do
						if gun:GetAttribute("Cooldown") then
							gun:SetAttribute("Cooldown", 0)
							gun.Parent = character
						end
					end

					if Core:CanShoot() then
						if not shot then
							for i = 1, 5 do
								local args = {
									humanoid_root_part.Position,
									humanoid_root_part.Position,
									humanoid_root_part,
									humanoid_root_part.Position
								}
								shoot_gun:FireServer(unpack(args))
							end

							shot = true
							shoot_time = now
							break
						elseif shot and (now - shoot_time >= delay) then
							local args = {
								humanoid_root_part.Position,
								humanoid_root_part.Position,
								humanoid_root_part,
								humanoid_root_part.Position
							}
							shoot_gun:FireServer(unpack(args))
						end
					end
				end
			end)

		else
			if Core.Connections.KillAll then
				Core.Connections.KillAll:Disconnect()
				Core.Connections.KillAll = nil
			end
			if Core.Connections.KillAllChar then
				Core.Connections.KillAllChar:Disconnect()
				Core.Connections.KillAllChar = nil
			end
			if Core.Connections.KillAllMatch then
				Core.Connections.KillAllMatch:Disconnect()
				Core.Connections.KillAllMatch = nil
			end
		end
	end
})
bindKey(KillAll)

AutoShoot = sections.combat_left:AddToggle({
	name = "Auto Shoot",
	default = Core.Features.AutoShoot.Enabled,
	callback = function(enabled)
		Core.Features.AutoShoot.Enabled = enabled

		if enabled then
			Core.Connections.AutoShoot = Services.RunService.Heartbeat:Connect(function()
				if not Core.Features.AutoShoot.Enabled then return end
				if not Core:CanShoot() then return end

				local character = LocalPlayer.Character
				if not character then return end

				local player_humanoid = character:FindFirstChildOfClass("Humanoid")
				if not player_humanoid or player_humanoid.Health <= 0 then return end

				local remotes = Services.ReplicatedStorage:FindFirstChild("Remotes")
				if not remotes then return end

				local shoot_gun = remotes:FindFirstChild("ShootGun")
				if not shoot_gun then return end

				
				local backpack = LocalPlayer.Backpack
				if backpack then
					for _, gun in next, backpack:GetChildren() do
						if gun:IsA("Tool") and gun:GetAttribute("Cooldown") ~= nil then
							gun:SetAttribute("Cooldown", 0)
							gun.Parent = character
						end
					end
				end

				local equipped = nil
				for _, tool in next, character:GetChildren() do
					if tool:IsA("Tool") and tool:GetAttribute("Cooldown") ~= nil then
						tool:SetAttribute("Cooldown", 0)
						equipped = tool
					end
				end

				local target_head = Core:GetAutoShootTarget()
				if not target_head then return end

				local hit_pos = target_head.Position

				
				for _ = 1, 3 do
					shoot_gun:FireServer(hit_pos, hit_pos, target_head, hit_pos)
				end

				if equipped then
					pcall(function()
						equipped:Activate()
					end)
				end
			end)
		else
			if Core.Connections.AutoShoot then
				Core.Connections.AutoShoot:Disconnect()
				Core.Connections.AutoShoot = nil
			end
		end
	end
})
bindKey(AutoShoot)

SilentAim = sections.combat_left:AddToggle({
	name = "Silent Aim",
	default = Core.Features.SilentAim.Enabled,
	callback = function(state)
		Core.Features.SilentAim.Enabled = state
	end
})
bindKey(SilentAim)

local namecall; namecall = hookmetamethod(game, "__namecall", function(self, ...)
	local args = {...}
	local method = getnamecallmethod()

	if not Core.Features.SilentAim.Enabled then
		return namecall(self, ...)
	end

	if not checkcaller() and method == "FireServer" then
		if self.Name == "ShootGun" or self.Name == "ThrowHit" then
			local closest = Core:GetClosest({
				range = Core.Features.SilentAim.Range,
				wall_check = Core.Features.SilentAim.WallCheck,
				priority = Core.Features.SilentAim.Priority
			})

			if closest then
				local head = closest.FindFirstChild(closest, "Head")
				if head then
					if self.Name == "ShootGun" then
						args[1] = head.Position
						args[2] = head.Position
						args[3] = head
						args[4] = head.Position

					elseif self.Name == "ThrowHit" then
						args[1] = head
						args[2] = head.Position
					end
				end
			end
		end

		return namecall(self, unpack(args))
	end

	return namecall(self, unpack(args))
end)

Core.Features.SilentAim.Hook = namecall


trackSlider("SilentAimRange", sections.combat_left:AddSlider({
	name = "Silent Aim Range",
	default = Core.Features.SilentAim.Range,
	min = 1,
	max = 500,
	callback = function(value)
		Core.Features.SilentAim.Range = value
	end
}))

SilentAimWallCheck = sections.combat_left:AddToggle({
	name = "Silent Aim Wall Check",
	default = Core.Features.SilentAim.WallCheck,
	callback = function(value)
		Core.Features.SilentAim.WallCheck = value
	end
})

sections.combat_left:AddDropdown({
	name = "Silent Aim Priority",
	list = {"Camera", "Character"},
	default = 1,
	min = 1,
	max = 1,
	callback = function(value)
		Core.Features.SilentAim.Priority = value
	end
})

KnifeAura = sections.combat_left:AddToggle({
	name = "Knife Aura",
	default = Core.Features.KnifeAura.Enabled,
	callback = function(enabled)
		Core.Features.KnifeAura.Enabled = enabled

		if enabled then
			local lastTick = 0
			local stabRemote = nil
			Core.Connections.KnifeAura = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.1 then return end
				lastTick = now

				local closest = Core:GetClosest({
					range = 500,
					priority = "Character",
					wall_check = false
				})
				if not closest then return end

				local humanoid = closest:FindFirstChildOfClass("Humanoid")
				if not humanoid or humanoid.Health <= 0 then return end

				local humanoid_root_part = closest:FindFirstChild("HumanoidRootPart")
				if not humanoid_root_part then return end

				if not stabRemote or not stabRemote.Parent then
					local remotes = Services.ReplicatedStorage:FindFirstChild("Remotes")
					stabRemote = remotes and remotes:FindFirstChild("Stab")
				end
				if not stabRemote then return end
				stabRemote:FireServer(humanoid_root_part)
			end)

		else
			if Core.Connections.KnifeAura then
				Core.Connections.KnifeAura:Disconnect()
				Core.Connections.KnifeAura = nil
			end
		end
	end
})
bindKey(KnifeAura)

SetCooldown = sections.combat_right:AddToggle({
	name = "Set Cooldown",
	default = Core.Features.SetCooldown.Enabled,
	callback = function(enabled)
		Core.Features.SetCooldown.Enabled = enabled

		if enabled then
			local lastTick = 0
			Core.Connections.SetCooldown = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.15 then return end
				lastTick = now

				local character = LocalPlayer.Character
				if not character then return end

				local backpack = LocalPlayer:FindFirstChild("Backpack")
				local cd = Core.Features.SetCooldown.Cooldown
				if backpack then
					for _, gun in next, backpack:GetChildren() do
						if gun:GetAttribute("Cooldown") ~= nil then
							gun:SetAttribute("Cooldown", cd)
						end
					end
				end
				for _, gun in next, character:GetChildren() do
					if gun:GetAttribute("Cooldown") ~= nil then
						gun:SetAttribute("Cooldown", cd)
					end
				end
			end)
		else
			if Core.Connections.SetCooldown then
				Core.Connections.SetCooldown:Disconnect()
				Core.Connections.SetCooldown = nil
			end
		end
	end
})
bindKey(SetCooldown)

trackSlider("SetCooldown", sections.combat_right:AddSlider({
	name = "Cooldown",
	default = Core.Features.SetCooldown.Cooldown,
	min = 0,
	max = 5,
	callback = function(value) 
		Core.Features.SetCooldown.Cooldown = value
	end
}))

SetThrowSpeed = sections.combat_right:AddToggle({
	name = "Set Throw Speed",
	default = Core.Features.SetThrowSpeed.Enabled,
	callback = function(enabled)
		Core.Features.SetThrowSpeed.Enabled = enabled

		if enabled then
			local lastTick = 0
			Core.Connections.SetThrowSpeed = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.15 then return end
				lastTick = now

				local character = LocalPlayer.Character
				if not character then return end

				local speed = Core.Features.SetThrowSpeed.Speed
				local backpack = LocalPlayer:FindFirstChild("Backpack")
				if backpack then
					for _, knife in next, backpack:GetChildren() do
						if knife:GetAttribute("ThrowSpeed") ~= nil then
							knife:SetAttribute("ThrowSpeed", speed)
						end
					end
				end
				for _, knife in next, character:GetChildren() do
					if knife:GetAttribute("ThrowSpeed") ~= nil then
						knife:SetAttribute("ThrowSpeed", speed)
					end
				end
			end)
		else
			if Core.Connections.SetThrowSpeed then
				Core.Connections.SetThrowSpeed:Disconnect()
				Core.Connections.SetThrowSpeed = nil
			end
		end
	end
})
bindKey(SetThrowSpeed)

trackSlider("SetThrowSpeed", sections.combat_right:AddSlider({
	name = "Speed",
	default = Core.Features.SetThrowSpeed.Speed,
	min = 0,
	max = 5000,
	callback = function(value) 
		Core.Features.SetThrowSpeed.Speed = value
	end
}))

HitboxExtender = sections.combat_right:AddToggle({
	name = "Hitbox Extender",
	default = Core.Features.HitboxExtender.Enabled,
	callback = function(enabled)
		Core.Features.HitboxExtender.Enabled = enabled

		if enabled then
			local lastTick = 0
			Core.Connections.HitboxExtender = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.2 then return end
				lastTick = now

				local size = tonumber(Core.Features.HitboxExtender.Size) or 50
				local transparency = tonumber(Core.Features.HitboxExtender.Transparency)
				if transparency == nil then transparency = 0.5 end

				for _, target in next, Services.Players:GetPlayers() do
					if target == LocalPlayer then continue end

					local character = target.Character
					if not character then continue end

					local humanoid_root_part = character:FindFirstChild("HumanoidRootPart")
					if not humanoid_root_part or not humanoid_root_part:IsA("BasePart") then continue end

					humanoid_root_part.Size = Vector3.new(size, size, size)
					humanoid_root_part.Transparency = transparency
					humanoid_root_part.CanCollide = false
					humanoid_root_part.Massless = true
					humanoid_root_part.Material = Enum.Material.ForceField
					humanoid_root_part.Color = Color3.fromRGB(255, 60, 60)
				end
			end)
		else
			if Core.Connections.HitboxExtender then
				Core.Connections.HitboxExtender:Disconnect()
				Core.Connections.HitboxExtender = nil
			end

			for _, target in next, Services.Players:GetPlayers() do
				if target == LocalPlayer then continue end

				local character = target.Character
				if not character then continue end

				local humanoid_root_part = character:FindFirstChild("HumanoidRootPart")
				if not humanoid_root_part or not humanoid_root_part:IsA("BasePart") then continue end

				humanoid_root_part.Size = Vector3.new(2, 1, 1)
				humanoid_root_part.Transparency = 1
				humanoid_root_part.CanCollide = false
				humanoid_root_part.Massless = false
				humanoid_root_part.Material = Enum.Material.Plastic
			end
		end
	end
})
bindKey(HitboxExtender)

trackSlider("HitboxSize", sections.combat_right:AddSlider({
	name = "Size",
	default = Core.Features.HitboxExtender.Size,
	min = 1,
	max = 100,
	callback = function(value)
		Core.Features.HitboxExtender.Size = value
	end
}))

trackSlider("HitboxTransparency", sections.combat_right:AddSlider({
	name = "Transparency",
	default = Core.Features.HitboxExtender.Transparency,
	min = 0,
	max = 1,
	callback = function(value)
		Core.Features.HitboxExtender.Transparency = value
	end
}))

CrashAll = sections.world_left:AddToggle({
	name = "Crash All",
	default = false,
	callback = function(enabled)
		if enabled then
			Notify("Crash All", "업데이트 대기중")
			Core.Features.CrashAll.Enabled = false
			task.defer(function()
				if CrashAll and CrashAll.UpdateState then
					CrashAll:UpdateState(false, false)
				end
			end)
			return
		end
		Core.Features.CrashAll.Enabled = false
	end
})
bindKey(CrashAll)

AntiCrash = sections.world_left:AddToggle({
	name = "Anti Crash",
	default = false,
	callback = function(enabled)
		if enabled then
			Notify("Anti Crash", "업데이트 대기중")
			Core.Features.AntiCrash.Enabled = false
			task.defer(function()
				if AntiCrash and AntiCrash.UpdateState then
					AntiCrash:UpdateState(false, false)
				end
			end)
			return
		end
		Core.Features.AntiCrash.Enabled = false
	end
})
bindKey(AntiCrash)

local function NoFog_GetAtmosphere()
	local lighting = Services.Lighting
	local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")
	if not atmosphere then
		atmosphere = Instance.new("Atmosphere")
		atmosphere.Parent = lighting
	end
	return atmosphere
end

local function NoFog_CaptureOriginal()
	local lighting = Services.Lighting
	local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")
	local original = {
		FogStart = lighting.FogStart,
		FogEnd = lighting.FogEnd,
		FogColor = lighting.FogColor,
		HadAtmosphere = atmosphere ~= nil,
	}
	if atmosphere then
		original.Density = atmosphere.Density
		original.Haze = atmosphere.Haze
		original.Glare = atmosphere.Glare
		original.Color = atmosphere.Color
		original.Decay = atmosphere.Decay
		original.Offset = atmosphere.Offset
	end
	return original
end

local function NoFog_Restore()
	local original = Core.Features.NoFog.Original
	if not original then return end

	local lighting = Services.Lighting
	pcall(function()
		lighting.FogStart = original.FogStart
		lighting.FogEnd = original.FogEnd
		lighting.FogColor = original.FogColor
	end)

	local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")
	if original.HadAtmosphere then
		if not atmosphere then
			atmosphere = Instance.new("Atmosphere")
			atmosphere.Parent = lighting
		end
		pcall(function()
			atmosphere.Density = original.Density
			atmosphere.Haze = original.Haze
			atmosphere.Glare = original.Glare
			atmosphere.Color = original.Color
			atmosphere.Decay = original.Decay
			if original.Offset ~= nil then
				atmosphere.Offset = original.Offset
			end
		end)
	elseif atmosphere then
		pcall(function()
			atmosphere:Destroy()
		end)
	end

	Core.Features.NoFog.Original = nil
end

local function NoFog_Apply()
	local lighting = Services.Lighting
	local atmosphere = NoFog_GetAtmosphere()
	local density = (tonumber(Core.Features.NoFog.Density) or 0) / 100
	local haze = tonumber(Core.Features.NoFog.Haze) or 0
	local glare = (tonumber(Core.Features.NoFog.Glare) or 0) / 100

	pcall(function()
		atmosphere.Density = density
		atmosphere.Haze = haze
		atmosphere.Glare = glare
		atmosphere.Color = Color3.fromRGB(255, 255, 255)
		atmosphere.Decay = Color3.fromRGB(255, 255, 255)
	end)

	pcall(function()
		lighting.FogStart = 0
		lighting.FogEnd = 100000
	end)
end

local function setNoFogEnabled(enabled)
	Core.Features.NoFog.Enabled = enabled

	if Core.Connections.NoFog then
		pcall(function()
			Core.Connections.NoFog:Disconnect()
		end)
		Core.Connections.NoFog = nil
	end

	if enabled then
		if not Core.Features.NoFog.Original then
			Core.Features.NoFog.Original = NoFog_CaptureOriginal()
		end
		NoFog_Apply()
		local lastApply = 0
		Core.Connections.NoFog = Services.RunService.Heartbeat:Connect(function()
			if not Core.Features.NoFog.Enabled then return end
			local now = tick()
			if (now - lastApply) < 1.5 then return end
			lastApply = now
			NoFog_Apply()
		end)
	else
		NoFog_Restore()
	end
end

NoFog = sections.world_left:AddToggle({
	name = "No Fog",
	default = Core.Features.NoFog.Enabled,
	callback = function(enabled)
		setNoFogEnabled(enabled)
	end
})
bindKey(NoFog)

trackSlider("FogDensity", sections.world_left:AddSlider({
	name = "fog density",
	default = Core.Features.NoFog.Density,
	min = 0,
	max = 100,
	changeby = 1,
	suffix = "%",
	callback = function(value)
		Core.Features.NoFog.Density = value
		if Core.Features.NoFog.Enabled then
			NoFog_Apply()
		end
	end
}))

trackSlider("FogHaze", sections.world_left:AddSlider({
	name = "fog haze",
	default = Core.Features.NoFog.Haze,
	min = 0,
	max = 10,
	changeby = 1,
	callback = function(value)
		Core.Features.NoFog.Haze = value
		if Core.Features.NoFog.Enabled then
			NoFog_Apply()
		end
	end
}))

trackSlider("FogGlare", sections.world_left:AddSlider({
	name = "fog glare",
	default = Core.Features.NoFog.Glare,
	min = 0,
	max = 100,
	changeby = 1,
	suffix = "%",
	callback = function(value)
		Core.Features.NoFog.Glare = value
		if Core.Features.NoFog.Enabled then
			NoFog_Apply()
		end
	end
}))

Flight = sections.mobility_left:AddToggle({
	name = "Flight",
	default = Core.Features.Flight.Enabled,
	callback = function(state)
		Core.Features.Flight.Enabled = state

		if state then
			Core.Connections.Flight = Services.RunService.PreRender:Connect(function(delta)
				local character, humanoid, humanoid_root_part = Core:GetParts(LocalPlayer)
				if not character or not humanoid or not humanoid_root_part then return end

				local move_direction = Vector3.zero

				if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) and not Services.UserInputService:GetFocusedTextBox() then
					move_direction += Vector3.new(0, 0, 1)
				end
				if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) and not Services.UserInputService:GetFocusedTextBox() then
					move_direction += Vector3.new(0, 0, -1)
				end
				if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) and not Services.UserInputService:GetFocusedTextBox() then
					move_direction += Vector3.new(-1, 0, 0)
				end
				if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) and not Services.UserInputService:GetFocusedTextBox() then
					move_direction += Vector3.new(1, 0, 0)
				end

				local vertical = 0
				if (Services.UserInputService:IsKeyDown(Enum.KeyCode.E) or Services.UserInputService:IsKeyDown(Enum.KeyCode.Space))
					and not Services.UserInputService:GetFocusedTextBox() then
					vertical = Core.Features.Flight.VerticalSpeed
				end
				if Services.UserInputService:IsKeyDown(Enum.KeyCode.Q) and not Services.UserInputService:GetFocusedTextBox() then
					vertical = -Core.Features.Flight.VerticalSpeed
				end

				if move_direction.Magnitude > 0 then
					move_direction = move_direction.Unit * Core.Features.Flight.HorizontalSpeed
				end

				local forward = Camera.CFrame.LookVector
				local right = Camera.CFrame.RightVector

				local final_move = (forward * move_direction.Z) + (right * move_direction.X) + (Vector3.yAxis * vertical)

				humanoid_root_part.CFrame += final_move * delta

				local velocity = humanoid_root_part.Velocity
				humanoid_root_part.Velocity = Vector3.new(velocity.X, 0.5, velocity.Z)
			end)
		else
			if Core.Connections.Flight then
				Core.Connections.Flight:Disconnect()
				Core.Connections.Flight = nil
			end
		end
	end
})
bindKey(Flight)

trackSlider("FlightH", sections.mobility_left:AddSlider({
	name = "Horizontal Speed",
	default = Core.Features.Flight.HorizontalSpeed,
	min = 0,
	max = 500,
	callback = function(v) Core.Features.Flight.HorizontalSpeed = v end
}))

trackSlider("FlightV", sections.mobility_left:AddSlider({
	name = "Vertical Speed",
	default = Core.Features.Flight.VerticalSpeed,
	min = 0,
	max = 500,
	callback = function(v) Core.Features.Flight.VerticalSpeed = v end
}))

Walkspeed = sections.mobility_left:AddToggle({
	name = "Walkspeed",
	default = Core.Features.Walkspeed.Enabled,
	callback = function(enabled)
		Core.Features.Walkspeed.Enabled = enabled

		if enabled then
			local lastTick = 0
			Core.Connections.Walkspeed = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.2 then return end
				lastTick = now
				local character, humanoid = Core:GetParts(LocalPlayer)
				if not humanoid then return end
				humanoid.WalkSpeed = Core.Features.Walkspeed.Speed
			end)
		else
			if Core.Connections.Walkspeed then
				Core.Connections.Walkspeed:Disconnect()
				Core.Connections.Walkspeed = nil
			end

			local character, humanoid, humanoid_root_part = Core:GetParts(LocalPlayer)
			if not character or not humanoid or not humanoid_root_part then return end

			humanoid.WalkSpeed = 16
		end
	end
})
bindKey(Walkspeed)

trackSlider("Walkspeed", sections.mobility_left:AddSlider({
	name = "Speed",
	default = Core.Features.Walkspeed.Speed,
	min = 0,
	max = 250,
	callback = function(value)
		Core.Features.Walkspeed.Speed = value
	end
}))

JumpPower = sections.mobility_left:AddToggle({
	name = "Jump Power",
	default = Core.Features.JumpPower.Enabled,
	callback = function(enabled)
		Core.Features.JumpPower.Enabled = enabled

		if enabled then
			local lastTick = 0
			Core.Connections.JumpPower = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.2 then return end
				lastTick = now
				local _, humanoid = Core:GetParts(LocalPlayer)
				if not humanoid then return end
				if humanoid.UseJumpPower then
					humanoid.JumpPower = Core.Features.JumpPower.Power
				else
					humanoid.JumpHeight = Core.Features.JumpPower.Power
				end
			end)
		else
			if Core.Connections.JumpPower then
				Core.Connections.JumpPower:Disconnect()
				Core.Connections.JumpPower = nil
			end

			local character, humanoid = Core:GetParts(LocalPlayer)
			if not humanoid then return end
			
			if humanoid.UseJumpPower then
				humanoid.JumpPower = 50
			else
				humanoid.JumpHeight = 7.2
			end
		end
	end
})
bindKey(JumpPower)

trackSlider("JumpPower", sections.mobility_left:AddSlider({
	name = "Power",
	default = Core.Features.JumpPower.Power,
	min = 0,
	max = 300,
	callback = function(value)
		Core.Features.JumpPower.Power = value
	end
}))

FOV = sections.mobility_left:AddToggle({
	name = "Field of View",
	default = Core.Features.FOV.Enabled,
	callback = function(enabled)
		Core.Features.FOV.Enabled = enabled

		if enabled then
			local lastTick = 0
			Core.Connections.FOV = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.2 then return end
				lastTick = now
				Camera.FieldOfView = Core.Features.FOV.Value
			end)
		else
			if Core.Connections.FOV then
				Core.Connections.FOV:Disconnect()
				Core.Connections.FOV = nil
			end

			Camera.FieldOfView = 70
		end
	end
})
bindKey(FOV)

trackSlider("FOV", sections.mobility_left:AddSlider({
	name = "FOV",
	default = Core.Features.FOV.Value,
	min = 0,
	max = 120,
	callback = function(value)
		Core.Features.FOV.Value = value
	end
}))

Gravity = sections.mobility_left:AddToggle({
	name = "Gravity",
	default = Core.Features.Gravity.Enabled,
	callback = function(enabled)
		Core.Features.Gravity.Enabled = enabled

		if enabled then
			local lastTick = 0
			Core.Connections.Gravity = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.2 then return end
				lastTick = now
				workspace.Gravity = Core.Features.Gravity.Value
			end)
		else
			if Core.Connections.Gravity then
				Core.Connections.Gravity:Disconnect()
				Core.Connections.Gravity = nil
			end

			workspace.Gravity = 196.2
		end
	end
})
bindKey(Gravity)

trackSlider("Gravity", sections.mobility_left:AddSlider({
	name = "Gravity",
	default = Core.Features.Gravity.Value,
	min = 0,
	max = 300,
	callback = function(v)
		Core.Features.Gravity.Value = v
	end
}))

Phase = sections.mobility_right:AddToggle({
	name = "Phase",
	default = Core.Features.Phase.Enabled,
	callback = function(enabled)
		Core.Features.Phase.Enabled = enabled

		if enabled then
			Core.Features.Phase.OriginalCollision = {}

			local lastScan = 0
			Core.Connections.Phase = Services.RunService.Heartbeat:Connect(function()
				local character = LocalPlayer.Character
				if not character then return end

				local now = tick()
				if (now - lastScan) >= 0.5 then
					lastScan = now
					for _, part in next, character:GetDescendants() do
						if part:IsA("BasePart") and Core.Features.Phase.OriginalCollision[part] == nil then
							Core.Features.Phase.OriginalCollision[part] = part.CanCollide
						end
					end
				end

				for part in next, Core.Features.Phase.OriginalCollision do
					if part and part.Parent then
						part.CanCollide = false
					end
				end
			end)
		else
			for part, canCollide in next, Core.Features.Phase.OriginalCollision do
				if part and part.Parent then
					part.CanCollide = canCollide
				end
			end

			Core.Features.Phase.OriginalCollision = {}

			if Core.Connections.Phase then
				Core.Connections.Phase:Disconnect()
				Core.Connections.Phase = nil
			end
		end
	end
})
bindKey(Phase)

LongJump = sections.mobility_right:AddToggle({
	name = "Long Jump",
	default = Core.Features.LongJump.Enabled,
	callback = function(enabled)
		Core.Features.LongJump.Enabled = enabled

		if enabled then
			local can_boost = true

			Core.Connections.LongJump = Services.RunService.PreRender:Connect(function()
				local character, humanoid, root = Core:GetParts(LocalPlayer)
				if not character or not humanoid or not root then return end

				if humanoid:GetState() == Enum.HumanoidStateType.Jumping and can_boost then
					local direction = root.CFrame.LookVector * Core.Features.LongJump.Boost
					root.Velocity += Vector3.new(direction.X, Core.Features.LongJump.Height, direction.Z)
					can_boost = false
				elseif humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
					can_boost = true
				end
			end)
		else
			if Core.Connections.LongJump then
				Core.Connections.LongJump:Disconnect()
				Core.Connections.LongJump = nil
			end
		end
	end
})
bindKey(LongJump)

trackSlider("LongJumpHeight", sections.mobility_right:AddSlider({
	name = "Height",
	default = Core.Features.LongJump.Height,
	min = 0,
	max = 500,
	callback = function(value)
		Core.Features.LongJump.Height = value
	end
}))

trackSlider("LongJumpBoost", sections.mobility_right:AddSlider({
	name = "Boost",
	default = Core.Features.LongJump.Boost,
	min = 0,
	max = 500,
	callback = function(value)
		Core.Features.LongJump.Boost = value
	end
}))

WallClimb = sections.mobility_right:AddToggle({
	name = "Wall Climb",
	default = Core.Features.WallClimb.Enabled,
	callback = function(enabled)
		Core.Features.WallClimb.Enabled = enabled

		if enabled then
			Core.Connections.WallClimb = Services.RunService.PreRender:Connect(function()
				local character, humanoid, root = Core:GetParts(LocalPlayer)
				if not character or not root then return end

				local ray_origin = root.Position
				local ray_direction = root.CFrame.LookVector * 2

				local params = RaycastParams.new()
				params.FilterDescendantsInstances = { character }
				params.FilterType = Enum.RaycastFilterType.Exclude

				local hit = workspace:Raycast(ray_origin, ray_direction, params)
				if not hit then return end

				local upperOrigin = ray_origin + Vector3.new(0, 2.5, 0)
				local upperHit = workspace:Raycast(upperOrigin, ray_direction, params)

				if upperHit then
					root.Velocity = Vector3.new(
						root.Velocity.X,
						Core.Features.WallClimb.Speed,
						root.Velocity.Z
					)
				else
					root.CFrame += root.CFrame.LookVector * 1.2
					root.Velocity = Vector3.zero
				end
			end)
		else
			if Core.Connections.WallClimb then
				Core.Connections.WallClimb:Disconnect()
				Core.Connections.WallClimb = nil
			end
		end
	end
})
bindKey(WallClimb)

trackSlider("WallClimb", sections.mobility_right:AddSlider({
	name = "Speed",
	default = Core.Features.WallClimb.Speed,
	min = 0,
	max = 100,
	callback = function(value)
		Core.Features.WallClimb.Speed = value
	end
}))

SpinBot = sections.mobility_right:AddToggle({
	name = "Spin Bot",
	default = Core.Features.SpinBot.Enabled,
	callback = function(enabled)
		Core.Features.SpinBot.Enabled = enabled

		if enabled then
			Core.Connections.SpinBot = Services.RunService.PreRender:Connect(function(delta)
				local character, humanoid, root = Core:GetParts(LocalPlayer)
				if not character or not humanoid or not root then return end

				humanoid.AutoRotate = false

				local rotation = math.rad(Core.Features.SpinBot.Speed) * delta * 60
				root.CFrame *= CFrame.Angles(0, rotation, 0)
			end)
		else
			if Core.Connections.SpinBot then
				Core.Connections.SpinBot:Disconnect()
				Core.Connections.SpinBot = nil
			end

			local character, humanoid = Core:GetParts(LocalPlayer)
			if humanoid then
				humanoid.AutoRotate = true
			end
		end
	end
})
bindKey(SpinBot)

trackSlider("SpinBot", sections.mobility_right:AddSlider({
	name = "Speed",
	default = Core.Features.SpinBot.Speed,
	min = 0,
	max = 100,
	callback = function(v)
		Core.Features.SpinBot.Speed = v
	end
}))

BunnyHop = sections.mobility_right:AddToggle({
	name = "Bunny Hop",
	default = Core.Features.BunnyHop.Enabled,
	callback = function(enabled)
		Core.Features.BunnyHop.Enabled = enabled

		if enabled then
			Core.Connections.BunnyHop = Services.RunService.PreRender:Connect(function(delta)
				local character = LocalPlayer.Character
				if not character then return end

				local humanoid = character:FindFirstChild("Humanoid")
				if not humanoid then return end

				if humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
		else
			if Core.Connections.BunnyHop then
				Core.Connections.BunnyHop:Disconnect()
				Core.Connections.BunnyHop = nil
			end
		end
	end
})
bindKey(BunnyHop)

local EspInstance = nil
PlayerESP = sections.render_left:AddToggle({
	name = "Player ESP",
	default = false,
	callback = function(enabled)
		Core.Features.PlayerESP.Enabled = enabled

		if enabled then
			EspInstance = PlayerESPLib.new({
				Box = Core.Features.PlayerESP.Box,
				Tracer = Core.Features.PlayerESP.Tracer,
				Arrows = Core.Features.PlayerESP.Arrows,
				Skeleton = Core.Features.PlayerESP.Skeleton,
				Name = Core.Features.PlayerESP.Name,
				Rainbow = Core.Features.PlayerESP.Rainbow,
				DefaultColor = Core.Features.PlayerESP.DefaultColor,
				MaxDistance = Core.Features.PlayerESP.MaxDistance
			})
			
			EspInstance:Enable()
		else
			if EspInstance then
				EspInstance:Disable()
				EspInstance = nil
			end
		end
	end
})
bindKey(PlayerESP)

ESPTeamCheck = sections.render_left:AddToggle({
	name = "Team Check",
	default = Core.Features.PlayerESP.TeamCheck,
	callback = function(value)
		Core.Features.PlayerESP.TeamCheck = value
		
		if value then
			local lastTick = 0
			Core.Connections.TeamCheck = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.4 then return end
				lastTick = now
				if not EspInstance then return end
				for _, target in next, Services.Players:GetPlayers() do
					if target.Team and LocalPlayer.Team and target.Team == LocalPlayer.Team then
						EspInstance:Destroy(target)
					else
						EspInstance:Add(target)
					end
				end
			end)
		else
			if Core.Connections.TeamCheck then
				Core.Connections.TeamCheck:Disconnect()
				Core.Connections.TeamCheck = nil
			end
		end
	end
})

ESPRemoveHidden = sections.render_left:AddToggle({
	name = "Remove Hidden Characters",
	default = Core.Features.PlayerESP.RemoveHiddenCharacters,
	callback = function(value)
		Core.Features.PlayerESP.RemoveHiddenCharacters = value

		if value then
			local lastTick = 0
			Core.Connections.RemoveHiddenCharacters = Services.RunService.Heartbeat:Connect(function()
				local now = tick()
				if (now - lastTick) < 0.4 then return end
				lastTick = now
				if not EspInstance then return end
				for _, target in next, Services.Players:GetPlayers() do
					local character = target.Character
					if not character or not character.Parent or not character.Parent.Parent then continue end
					if character.Parent.Parent == Services.ReplicatedStorage then
						EspInstance:Destroy(target)
					else
						EspInstance:Add(target)
					end
				end
			end)
		else
			if Core.Connections.RemoveHiddenCharacters then
				Core.Connections.RemoveHiddenCharacters:Disconnect()
				Core.Connections.RemoveHiddenCharacters = nil
			end
		end
	end
})

ESPBox = sections.render_left:AddToggle({
	name = "Box",
	default = false,
	callback = function(state)
		Core.Features.PlayerESP.Box = state
		
		if EspInstance then
			EspInstance.Box = state
		end
	end
})

ESPTracer = sections.render_left:AddToggle({
	name = "Tracer",
	default = false,
	callback = function(state)
		Core.Features.PlayerESP.Tracer = state
		
		if EspInstance then
			EspInstance.Tracer = state
		end
	end
})

ESPSkeleton = sections.render_left:AddToggle({
	name = "Skeleton",
	default = false,
	callback = function(state)
		Core.Features.PlayerESP.Skeleton = state
		
		if EspInstance then
			EspInstance.Skeleton = state
		end
	end
})

ESPArrows = sections.render_left:AddToggle({
	name = "Arrows",
	default = false,
	callback = function(state)
		Core.Features.PlayerESP.Arrows = state
		
		if EspInstance then
			EspInstance.Arrows = state
		end
	end
})

ESPName = sections.render_left:AddToggle({
	name = "Name",
	default = false,
	callback = function(state)
		Core.Features.PlayerESP.Name = state
		
		if EspInstance then
			EspInstance.Name = state
		end
	end
})

ESPRainbow = sections.render_left:AddToggle({
	name = "Rainbow",
	default = false,
	callback = function(state)
		Core.Features.PlayerESP.Rainbow = state
		
		if EspInstance then
			EspInstance.Rainbow = state
		end
	end
})

PlayerESP:AddColorpicker({
	default = Core.Features.PlayerESP.DefaultColor,
	getcolor = function(color)
		Core.Features.PlayerESP.DefaultColor = color
		if EspInstance then
			EspInstance.DefaultColor = color
			for _, target_player in next, Services.Players:GetPlayers() do
				if target_player ~= LocalPlayer then
					EspInstance:SetColor(target_player, color)
				end
			end
		end
	end,
})

local AuraState = {
	Attachment = nil,
	Emitters = {},
}

local function destroyAura()
	for _, emitter in next, AuraState.Emitters do
		if emitter and emitter.Parent then
			emitter:Destroy()
		end
	end
	AuraState.Emitters = {}

	if AuraState.Attachment and AuraState.Attachment.Parent then
		AuraState.Attachment:Destroy()
	end
	AuraState.Attachment = nil
end

local function createAuraEmitters(attachment)
	local HealingWave1 = Instance.new("ParticleEmitter")
	HealingWave1.Name = "Healing Wave 1"
	HealingWave1.Lifetime = NumberRange.new(1.5, 1.5)
	HealingWave1.SpreadAngle = Vector2.new(10, -10)
	HealingWave1.LockedToPart = true
	HealingWave1.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.1702454, 0.7, 0.014881),
		NumberSequenceKeypoint.new(0.2254601, 0.03125, 0.03125),
		NumberSequenceKeypoint.new(0.2852761, 0),
		NumberSequenceKeypoint.new(0.702454, 0),
		NumberSequenceKeypoint.new(0.8374233, 0.9125, 0.0601461),
		NumberSequenceKeypoint.new(1, 1),
	})
	HealingWave1.LightEmission = 0.4
	HealingWave1.Color = ColorSequence.new(Color3.fromRGB(234, 8, 255))
	HealingWave1.VelocitySpread = 10
	HealingWave1.Speed = NumberRange.new(3, 6)
	HealingWave1.Brightness = 10
	HealingWave1.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 3.0624998, 1.8805969),
		NumberSequenceKeypoint.new(0.6420546, 1.9999999, 1.7619393),
		NumberSequenceKeypoint.new(1, 0.7499999, 0.7499999),
	})
	HealingWave1.Rate = 20
	HealingWave1.Texture = "rbxassetid://8047533775"
	HealingWave1.RotSpeed = NumberRange.new(200, 400)
	HealingWave1.Rotation = NumberRange.new(-180, 180)
	HealingWave1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	HealingWave1.Enabled = true
	HealingWave1.Parent = attachment

	local HealingWave2 = Instance.new("ParticleEmitter")
	HealingWave2.Name = "Healing Wave 2"
	HealingWave2.Lifetime = NumberRange.new(1.5, 1.5)
	HealingWave2.SpreadAngle = Vector2.new(10, -10)
	HealingWave2.LockedToPart = true
	HealingWave2.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.2254601, 0.03125, 0.03125),
		NumberSequenceKeypoint.new(0.6288344, 0.25625, 0.0593491),
		NumberSequenceKeypoint.new(0.8374233, 0.9125, 0.0601461),
		NumberSequenceKeypoint.new(1, 1),
	})
	HealingWave2.LightEmission = 1
	HealingWave2.Color = ColorSequence.new(Color3.fromRGB(238, 3, 255))
	HealingWave2.VelocitySpread = 10
	HealingWave2.Speed = NumberRange.new(3, 5)
	HealingWave2.Brightness = 10
	HealingWave2.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 3.125),
		NumberSequenceKeypoint.new(0.4165329, 1.3749999, 1.3749999),
		NumberSequenceKeypoint.new(1, 0.9375, 0.9375),
	})
	HealingWave2.Rate = 20
	HealingWave2.Texture = "rbxassetid://8047796070"
	HealingWave2.RotSpeed = NumberRange.new(100, 300)
	HealingWave2.Rotation = NumberRange.new(-180, 180)
	HealingWave2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	HealingWave2.Enabled = true
	HealingWave2.Parent = attachment

	local Sparks = Instance.new("ParticleEmitter")
	Sparks.Name = "Sparks"
	Sparks.Lifetime = NumberRange.new(0.5, 2)
	Sparks.SpreadAngle = Vector2.new(180, -180)
	Sparks.LightEmission = 1
	Sparks.Color = ColorSequence.new(Color3.fromRGB(255, 21, 255))
	Sparks.Drag = 3
	Sparks.VelocitySpread = 180
	Sparks.Speed = NumberRange.new(5, 15)
	Sparks.Brightness = 10
	Sparks.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.14687, 0.4374999, 0.1875001),
		NumberSequenceKeypoint.new(1, 0),
	})
	Sparks.Acceleration = Vector3.new(0, 3, 0)
	Sparks.ZOffset = -1
	Sparks.Rate = 40
	Sparks.Texture = "rbxassetid://8611887361"
	Sparks.RotSpeed = NumberRange.new(-30, 30)
	Sparks.Orientation = Enum.ParticleOrientation.VelocityParallel
	Sparks.Enabled = true
	Sparks.Parent = attachment

	local StarSparks = Instance.new("ParticleEmitter")
	StarSparks.Name = "Star Sparks"
	StarSparks.Lifetime = NumberRange.new(1.5, 1.5)
	StarSparks.SpreadAngle = Vector2.new(180, -180)
	StarSparks.LightEmission = 1
	StarSparks.Color = ColorSequence.new(Color3.fromRGB(226, 60, 255))
	StarSparks.Drag = 3
	StarSparks.VelocitySpread = 180
	StarSparks.Speed = NumberRange.new(5, 10)
	StarSparks.Brightness = 10
	StarSparks.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.1492777, 0.6874996, 0.6874996),
		NumberSequenceKeypoint.new(1, 0),
	})
	StarSparks.Acceleration = Vector3.new(0, 3, 0)
	StarSparks.ZOffset = 2
	StarSparks.Rate = 20
	StarSparks.Texture = "rbxassetid://8611887703"
	StarSparks.RotSpeed = NumberRange.new(-30, 30)
	StarSparks.Rotation = NumberRange.new(-30, 30)
	StarSparks.Enabled = true
	StarSparks.Parent = attachment

	AuraState.Emitters = { HealingWave1, HealingWave2, Sparks, StarSparks }
end

local function attachAura(character)
	destroyAura()
	if not character then return end

	local attach_part = character:FindFirstChild("LowerTorso")
		or character:FindFirstChild("Torso")
		or character:FindFirstChild("HumanoidRootPart")
	if not attach_part then return end

	local attachment = Instance.new("Attachment")
	attachment.Name = "SalboAura"
	attachment.Parent = attach_part
	AuraState.Attachment = attachment

	createAuraEmitters(attachment)
end

local function setAuraEnabled(enabled)
	Core.Features.Aura.Enabled = enabled

	if Core.Connections.AuraCharacter then
		Core.Connections.AuraCharacter:Disconnect()
		Core.Connections.AuraCharacter = nil
	end

	if enabled then
		if LocalPlayer.Character then
			attachAura(LocalPlayer.Character)
		end

		Core.Connections.AuraCharacter = LocalPlayer.CharacterAdded:Connect(function(character)
			character:WaitForChild("Humanoid", 5)
			task.wait(0.15)
			if Core.Features.Aura.Enabled then
				attachAura(character)
			end
		end)
	else
		destroyAura()
	end
end

Aura = sections.render_right:AddToggle({
	name = "Aura",
	default = Core.Features.Aura.Enabled,
	callback = function(enabled)
		setAuraEnabled(enabled)
	end,
})
bindKey(Aura)

local function SkinChanger_SaveToFile()
	if not writefile then return end
	pcall(function()
		Core:EnsureConfigFolder()
	end)
	local ok, encoded = pcall(function()
		return Services.HttpService:JSONEncode(Core.Features.SkinChanger.Saved)
	end)
	if ok then
		pcall(writefile, Core.Features.SkinChanger.SaveFile, encoded)
	end
end

local function SkinChanger_LoadFromFile()
	if not isfile or not readfile then return end
	if not isfile(Core.Features.SkinChanger.SaveFile) then return end
	local ok, decoded = pcall(function()
		return Services.HttpService:JSONDecode(readfile(Core.Features.SkinChanger.SaveFile))
	end)
	if ok and type(decoded) == "table" then
		Core.Features.SkinChanger.Saved = decoded
	end
end

local function SkinChanger_Apply(userId, notifyName, silent)
	local userIdNum = tonumber(userId)
	if not userIdNum then
		if not silent then
			Notify("Skin Changer", "UserId를 숫자로 입력하세요")
		end
		return false
	end

	local character = LocalPlayer.Character
	if not character then
		if not silent then
			Notify("Skin Changer", "캐릭터가 없습니다")
		end
		return false
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		if not silent then
			Notify("Skin Changer", "살아 있을 때만 사용 가능")
		end
		return false
	end

	if Core.Features.SkinChanger.Applying then
		return false
	end
	Core.Features.SkinChanger.Applying = true

	local function finish(okResult)
		Core.Features.SkinChanger.Applying = false
		if okResult then
			Core.Features.SkinChanger.ActiveId = userIdNum
			Core.Features.SkinChanger.UserId = tostring(userIdNum)
			if not silent then
				Notify("Skin Changer", (notifyName or tostring(userIdNum)) .. " 적용됨")
			end
		end
		return okResult
	end

	do
		local okDesc, desc = pcall(function()
			return Services.Players:GetHumanoidDescriptionFromUserIdAsync(userIdNum)
		end)
		if okDesc and desc then
			local okApply = pcall(function()
				humanoid:ApplyDescription(desc)
			end)
			if okApply then
				return finish(true)
			end
		end
	end

	local ok, appearanceModel = pcall(function()
		return Services.Players:GetCharacterAppearanceAsync(userIdNum)
	end)

	if not ok or not appearanceModel then
		Core.Features.SkinChanger.Applying = false
		if not silent then
			Notify("Skin Changer", "외형 로드 실패")
		end
		return false
	end

	for _, inst in ipairs(character:GetChildren()) do
		if inst:IsA("Accessory")
			or inst:IsA("Shirt")
			or inst:IsA("Pants")
			or inst:IsA("BodyColors")
			or inst:IsA("ShirtGraphic") then
			inst:Destroy()
		end
	end

	local head = character:FindFirstChild("Head")
	if head then
		for _, inst in ipairs(head:GetChildren()) do
			if inst:IsA("SpecialMesh") and inst:GetAttribute("FromMorph") == true then
				inst:Destroy()
			end
			if inst:IsA("Decal") and (inst.Name == "face" or inst.Name == "Face") then
				inst:Destroy()
			end
		end
	end

	for _, inst in ipairs(appearanceModel:GetChildren()) do
		if inst:IsA("Shirt")
			or inst:IsA("Pants")
			or inst:IsA("BodyColors")
			or inst:IsA("ShirtGraphic") then
			inst:Clone().Parent = character
		elseif inst:IsA("Accessory") then
			local clone = inst:Clone()
			clone.Name = "#ACCESSORY_" .. clone.Name
			local added = false
			pcall(function()
				humanoid:AddAccessory(clone)
				added = clone.Parent ~= nil
			end)
			if not added then
				clone.Parent = character
			end
		elseif inst:IsA("SpecialMesh") and head then
			local clone = inst:Clone()
			clone:SetAttribute("FromMorph", true)
			clone.Parent = head
		elseif inst.Name == "R6" and humanoid.RigType == Enum.HumanoidRigType.R6 then
			local cm = inst:FindFirstChildOfClass("CharacterMesh")
			if cm then cm:Clone().Parent = character end
		elseif inst.Name == "R15" and humanoid.RigType == Enum.HumanoidRigType.R15 then
			local cm = inst:FindFirstChildOfClass("CharacterMesh")
			if cm then cm:Clone().Parent = character end
		end
	end

	if head then
		local faceInModel = appearanceModel:FindFirstChild("face") or appearanceModel:FindFirstChild("Face")
		if faceInModel and faceInModel:IsA("Decal") then
			faceInModel:Clone().Parent = head
		elseif not head:FindFirstChild("face") then
			local decal = Instance.new("Decal")
			decal.Face = Enum.NormalId.Front
			decal.Name = "face"
			decal.Texture = "rbxasset://textures/face.png"
			decal.Parent = head
		end
	end

	pcall(function()
		appearanceModel:Destroy()
	end)

	return finish(true)
end

local SkinSavedDropdown = nil

local function SkinChanger_SaveCurrent()
	local userIdNum = tonumber(Core.Features.SkinChanger.UserId)
	if not userIdNum then
		Notify("Skin Changer", "UserId를 먼저 입력하세요")
		return
	end

	local ok, name = pcall(function()
		return Services.Players:GetNameFromUserIdAsync(userIdNum)
	end)
	if not ok or not name then
		name = "User_" .. tostring(userIdNum)
	end

	Core.Features.SkinChanger.Saved[name] = userIdNum
	SkinChanger_SaveToFile()
	if SkinSavedDropdown and SkinSavedDropdown.AddChoice then
		pcall(function()
			SkinSavedDropdown:AddChoice(name)
		end)
	end
	Notify("Skin Changer", name .. " 저장됨")
end

local function SkinChanger_ReapplyOnSpawn(character)
	local activeId = Core.Features.SkinChanger.ActiveId or tonumber(Core.Features.SkinChanger.UserId)
	if not activeId or not character then
		return
	end

	task.spawn(function()
		local humanoid = character:WaitForChild("Humanoid", 10)
		if not humanoid then return end
		character:WaitForChild("HumanoidRootPart", 10)

		pcall(function()
			if LocalPlayer.CharacterAppearanceLoaded then
				if not LocalPlayer:HasAppearanceLoaded() then
					LocalPlayer.CharacterAppearanceLoaded:Wait()
				end
			end
		end)
		task.wait(0.25)

		if LocalPlayer.Character ~= character then return end
		if humanoid.Health <= 0 then return end

		SkinChanger_Apply(activeId, nil, true)
	end)
end

local function SkinChanger_GetSavedNames()
	local names = {}
	for name in pairs(Core.Features.SkinChanger.Saved) do
		table.insert(names, name)
	end
	table.sort(names)
	if #names == 0 then
		return { "(none)" }
	end
	return names
end

SkinChanger_LoadFromFile()

if Core.Connections.SkinChangerSpawn then
	pcall(function()
		Core.Connections.SkinChangerSpawn:Disconnect()
	end)
end
Core.Connections.SkinChangerSpawn = LocalPlayer.CharacterAdded:Connect(SkinChanger_ReapplyOnSpawn)
if LocalPlayer.Character then
	SkinChanger_ReapplyOnSpawn(LocalPlayer.Character)
end

sections.skins_left:AddTextbox({
	name = "roblox user id",
	default = Core.Features.SkinChanger.UserId ~= "" and Core.Features.SkinChanger.UserId or "",
	callback = function(text)
		Core.Features.SkinChanger.UserId = tostring(text or "")
	end,
})

sections.skins_left:AddButton({
	name = "apply skin",
	callback = function()
		SkinChanger_Apply(Core.Features.SkinChanger.UserId)
	end,
})

sections.skins_left:AddButton({
	name = "save skin",
	callback = function()
		SkinChanger_SaveCurrent()
	end,
})

SkinSavedDropdown = sections.skins_left:AddDropdown({
	name = "saved skins",
	list = SkinChanger_GetSavedNames(),
	default = 1,
	min = 0,
	max = 1,
	callback = function(selected)
		if not selected or selected == "" or selected == "(none)" then return end
		local userId = Core.Features.SkinChanger.Saved[selected]
		if userId then
			Core.Features.SkinChanger.UserId = tostring(userId)
			SkinChanger_Apply(userId, selected)
		end
	end,
})

sections.skins_left:AddButton({
	name = "clear active skin",
	callback = function()
		Core.Features.SkinChanger.ActiveId = nil
		Notify("Skin Changer", "리스폰 시 재적용 해제됨")
	end,
})

sections.settings_right:AddButton({
	name = "copy discord",
	callback = function()
		if setclipboard then
			setclipboard("https://discord.gg/404")
			Notify("Discord", "복사됨")
		end
	end,
})

--[[ AUTO QUEUE / REEXEC ]]--
-- Flow: 플레이 → 1v1 → 매칭 대기 → (맵 이동 시 reexec) → 로비 복귀 후 반복
-- Auto Queue ON일 때만 매치 입장 시 Kill All / Spin Bot / Render 자동 ON

local DUEL_PLACE_IDS = {
	[124848751642883] = "1v1",
	[92876937625630] = "2v2",
	[101617670515690] = "3v3",
	[74084441161738] = "pro",
}

local LOBBY_PLACE_IDS = {
	[15385224902] = true,
	[12355337193] = true,
}

local function isLobbyPlace()
	return LOBBY_PLACE_IDS[game.PlaceId] == true
end

local function isDuelPlace()
	return DUEL_PLACE_IDS[game.PlaceId] ~= nil
end

local function isInMatch()
	-- 별도 듀얼 맵
	if isDuelPlace() then
		return true
	end

	-- Match 속성 (이 게임이 로비와 같은 place에서 매치함)
	local m = LocalPlayer:GetAttribute("Match")
	if type(m) == "string" and #m > 0 then return true end
	if type(m) == "number" and m ~= 0 then return true end
	if m == true then return true end

	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if not pg then
		return not isLobbyPlace()
	end

	-- RoundCountdown 켜짐 = 라운드/매치 중
	local rc = pg:FindFirstChild("RoundCountdown")
	if rc and rc:IsA("LayerCollector") and rc.Enabled == true then
		return true
	end

	-- 매치 HUD
	for _, child in ipairs(pg:GetChildren()) do
		if child:IsA("LayerCollector") and child.Enabled then
			local n = string.lower(tostring(child.Name))
			if string.find(n, "queue", 1, true)
				or string.find(n, "lobby", 1, true)
				or string.find(n, "loading", 1, true)
				or string.find(n, "emote", 1, true)
			then
				-- skip
			elseif string.find(n, "match", 1, true)
				or string.find(n, "round", 1, true)
				or string.find(n, "duel", 1, true)
				or string.find(n, "score", 1, true)
				or string.find(n, "ingame", 1, true)
				or string.find(n, "gamehud", 1, true)
				or n == "hud"
			then
				return true
			end
		end
	end

	-- 로비 place가 아니면 매치
	if not isLobbyPlace() then
		return true
	end

	return false
end

local function canRunAutoQueue()
	return not isInMatch()
end

local function normalizeGuiText(s)
	s = tostring(s or ""):lower()
	s = s:gsub("<.->", "")
	s = s:gsub("[%s\n\r\t]+", " ")
	s = s:gsub("^%s+", ""):gsub("%s+$", "")
	return s
end

local AutoQueueState = {
	Running = false,
	Thread = nil,
	Lock = false,
	Phase = "play",
	LastAttempt = 0,
}

local setupAutoReexec -- forward decl

local function getHubWindow()
	if Core.HubWindow and Core.HubWindow.Parent and Core.HubWindow:IsA("GuiObject") then
		return Core.HubWindow, Core.HubScreenGui
	end
	local parents = {}
	pcall(function() table.insert(parents, game:GetService("CoreGui")) end)
	pcall(function() table.insert(parents, LocalPlayer:FindFirstChild("PlayerGui")) end)
	for _, parent in ipairs(parents) do
		if parent then
			for _, gui in ipairs(parent:GetChildren()) do
				if gui:IsA("ScreenGui") then
					for _, desc in ipairs(gui:GetDescendants()) do
						if desc.Name == "Window" and desc:IsA("GuiObject") and desc:FindFirstChild("mb") then
							Core.HubWindow = desc
							Core.HubScreenGui = gui
							return desc, gui
						end
					end
				end
			end
		end
	end
	return nil, nil
end

local function fireConnections(obj)
	if not obj then return false end
	local fired = false
	pcall(function()
		if typeof(getconnections) ~= "function" then return end
		-- Activated / Click only — Down까지 쏘면 가입 요청이 중복됨
		for _, sigName in ipairs({ "Activated", "MouseButton1Click" }) do
			local signal = obj[sigName]
			if signal then
				local ok, conns = pcall(getconnections, signal)
				if ok and type(conns) == "table" then
					for _, c in ipairs(conns) do
						pcall(function()
							if c.Fire then c:Fire()
							elseif c.Function then c.Function()
							end
						end)
						fired = true
					end
				end
			end
			if fired then return end
		end
	end)
	if not fired then
		pcall(function()
			if typeof(firesignal) == "function" and obj:IsA("GuiButton") then
				pcall(firesignal, obj.Activated)
				fired = true
			end
		end)
	end
	return fired
end

local _GuiScanCache = { at = 0, list = nil }

local function clickGui(inst)
	if not inst then return false end
	_GuiScanCache.at = 0
	_GuiScanCache.list = nil

	local target = inst
	if not (target:IsA("GuiButton") or target:IsA("ImageButton")) then
		target = inst:FindFirstAncestorWhichIsA("GuiButton")
	end
	if not target or not target:IsA("GuiObject") then return false end

	AutoQueueState.Lock = true

	local win = getHubWindow()
	local oldPos, oldModal
	local modalBtn
	if win and win:IsA("GuiObject") then
		oldPos = win.Position
		pcall(function()
			win.Position = UDim2.new(5, 0, 5, 0)
		end)
		modalBtn = win:FindFirstChild("mb")
		if modalBtn and modalBtn:IsA("GuiButton") then
			oldModal = modalBtn.Modal
			modalBtn.Modal = false
		end
	end

	task.wait(0.1)

	-- connections + VIM 둘 다 (한쪽만으론 안 먹는 경우 있음)
	fireConnections(target)
	pcall(function()
		local vim = game:GetService("VirtualInputManager")
		local inset = game:GetService("GuiService"):GetGuiInset()
		local pos = target.AbsolutePosition
		local size = target.AbsoluteSize
		if size.X <= 0 or size.Y <= 0 then return end
		local x = pos.X + size.X * 0.5
		local y = pos.Y + size.Y * 0.5 + inset.Y
		vim:SendMouseMoveEvent(x, y, game)
		task.wait(0.03)
		vim:SendMouseButtonEvent(x, y, 0, true, game, 1)
		task.wait(0.05)
		vim:SendMouseButtonEvent(x, y, 0, false, game, 1)
	end)

	if win and oldPos then
		pcall(function()
			win.Position = oldPos
		end)
	end
	if modalBtn and oldModal ~= nil then
		modalBtn.Modal = oldModal
	end

	task.delay(0.35, function()
		AutoQueueState.Lock = false
	end)

	return true
end

local function isVisibleGui(d)
	if not d then return false end
	if d:IsA("LayerCollector") then
		return d.Enabled == true
	end
	if not d:IsA("GuiObject") then
		return false
	end
	return d.Visible == true and d.AbsoluteSize.X > 0 and d.AbsoluteSize.Y > 0
end

local function isIgnoredQueuePath(d)
	local p = d
	for _ = 1, 14 do
		if not p then break end
		local n = string.lower(tostring(p.Name))
		if n == "queuehud"
			or n == "searchingframe"
			or n == "emotes"
			or n == "chat"
			or n == "bubblechat"
			or string.find(n, "search", 1, true)
		then
			return true
		end
		p = p.Parent
	end
	return false
end

local function pathHas(d, needle)
	needle = string.lower(tostring(needle or ""))
	if needle == "" then return true end
	local ok, full = pcall(function() return string.lower(d:GetFullName()) end)
	if not ok or not full then return false end
	return string.find(full, needle, 1, true) ~= nil
end

local function collectButtonText(btn)
	local parts = {}
	if btn:IsA("TextButton") or btn:IsA("TextLabel") then
		table.insert(parts, tostring(btn.Text or ""))
	end
	for _, ch in ipairs(btn:GetDescendants()) do
		if ch:IsA("TextLabel") or ch:IsA("TextButton") then
			table.insert(parts, tostring(ch.Text or ""))
		end
	end
	return normalizeGuiText(table.concat(parts, " "))
end

local function isQueueSearching()
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if not pg then return false end

	-- SearchingFrame Visible 만으로는 오탐 많음 → 실제 "찾고 있습니다" 문구만 인정
	local function textLooksSearching(t)
		t = normalizeGuiText(t)
		if t == "" then return false end
		if string.find(t, "찾고 있습니다", 1, true) then return true end
		if string.find(t, "플레이어들 찾고", 1, true) then return true end
		if string.find(t, "플레이어를 찾는", 1, true) then return true end
		if string.find(t, "searching for", 1, true) then return true end
		if string.find(t, "finding players", 1, true) then return true end
		return false
	end

	local qhud = pg:FindFirstChild("QueueHUD")
	if qhud and (not qhud:IsA("LayerCollector") or qhud.Enabled) then
		local searching = qhud:FindFirstChild("SearchingFrame", true)
		if searching and searching:IsA("GuiObject") and searching.Visible == true
			and searching.AbsoluteSize.X > 8 and searching.AbsoluteSize.Y > 8
		then
			for _, d in ipairs(searching:GetDescendants()) do
				if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Visible then
					if textLooksSearching(d.Text) then
						return true
					end
				end
			end
		end
	end

	return false
end

local _JoinErrCache = { at = 0, hit = false }
local function hasJoinErrorToast()
	local now = tick()
	if (now - _JoinErrCache.at) < 1.0 then
		return _JoinErrCache.hit
	end
	_JoinErrCache.at = now
	_JoinErrCache.hit = false
	if isQueueSearching() then return false end
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if not pg then return false end
	-- 전체 GetDescendants 대신 캐시된 스캔 사용
	scanPlayerGui(function(d)
		if _JoinErrCache.hit then return end
		if not (d:IsA("TextLabel") or d:IsA("TextButton")) then return end
		local okVis, vis = pcall(isVisibleGui, d)
		if not (okVis and vis) then return end
		local t = normalizeGuiText(d.Text)
		if string.find(t, "가입 오류", 1, true) or string.find(t, "join error", 1, true) then
			local name = string.lower(tostring(d.Name))
			if not string.find(name, "salbo", 1, true) then
				_JoinErrCache.hit = true
			end
		end
	end)
	return _JoinErrCache.hit
end

local function scanPlayerGui(callback)
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if not pg then return end
	local now = tick()
	if (not _GuiScanCache.list) or (now - _GuiScanCache.at) > 0.75 then
		_GuiScanCache.list = pg:GetDescendants()
		_GuiScanCache.at = now
	end
	for _, d in ipairs(_GuiScanCache.list) do
		if d and d.Parent then
			callback(d)
		end
	end
end

local function isModeMenuOpen()
	local has1, has2, has3 = false, false, false
	scanPlayerGui(function(d)
		if isIgnoredQueuePath(d) then return end
		if not pathHas(d, "queuegamemodes") and not pathHas(d, "duelmodes") then
			-- still allow if all three modes visible elsewhere
		end
		if (d:IsA("TextLabel") or d:IsA("TextButton")) and isVisibleGui(d) then
			local t = normalizeGuiText(d.Text)
			if t == "1v1" then has1 = true end
			if t == "2v2" then has2 = true end
			if t == "3v3" then has3 = true end
		end
	end)
	return has1 and has2 and has3
end

local function findTextButtonExact(exactText, opts)
	opts = opts or {}
	local want = normalizeGuiText(exactText)
	local best, bestArea = nil, opts.preferSmall and math.huge or -1
	local labelRef = nil
	scanPlayerGui(function(d)
		if not isVisibleGui(d) then return end
		if isIgnoredQueuePath(d) then return end
		if opts.requirePath and not pathHas(d, opts.requirePath) then return end

		local textVal = ""
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			textVal = normalizeGuiText(d.Text)
		elseif d:IsA("GuiButton") or d:IsA("ImageButton") then
			textVal = collectButtonText(d)
			if textVal == "" then
				textVal = normalizeGuiText(d.Name)
			end
		else
			return
		end

		local matched = (textVal == want)
		if opts.contains and not matched then
			matched = string.find(textVal, want, 1, true) ~= nil
		end
		if not matched then return end

		local target = (d:IsA("GuiButton") or d:IsA("ImageButton")) and d or d:FindFirstAncestorWhichIsA("GuiButton")
		if not target or not (target:IsA("GuiButton") or target:IsA("ImageButton")) then return end
		if not isVisibleGui(target) then return end
		if isIgnoredQueuePath(target) then return end
		if opts.requirePath and not pathHas(target, opts.requirePath) then return end

		if opts.skipBeginner then
			local blob = collectButtonText(target)
			if string.find(blob, "beginner", 1, true) then return end
			-- exact mode label must be exactly want (not "beginner 1v1")
			if want == "1v1" and blob ~= "1v1" and not string.find(blob, "^1v1$") then
				-- allow if blob has 1v1 as standalone word without beginner
				if string.find(blob, "beginner", 1, true) then return end
				local only = blob:gsub("[%s%-_]+", "")
				if only ~= "1v1" and textVal ~= "1v1" then return end
			end
		end

		local area = target.AbsoluteSize.X * target.AbsoluteSize.Y
		if area <= 0 then return end
		if opts.preferSmall then
			if area < bestArea then
				bestArea = area
				best = target
				labelRef = d
			end
		else
			local score = area + target.AbsolutePosition.Y * 5
			if score > bestArea then
				bestArea = score
				best = target
				labelRef = d
			end
		end
	end)
	return best, labelRef
end

local function waitForMatchOrQueue(timeoutSec)
	local startT = tick()
	timeoutSec = timeoutSec or 180
	local lastSawSearch = isQueueSearching() and tick() or 0
	local joinErrChecked = false

	AutoQueueState.Phase = "wait"

	while AutoQueueState.Running and Core.Settings.AutoQueue and (tick() - startT) < timeoutSec do
		if isInMatch() or not canRunAutoQueue() then
						return true
		end

		if isQueueSearching() then
			lastSawSearch = tick()
			task.wait(2)
		else
			local elapsed = tick() - startT
			local sinceSearch = (lastSawSearch > 0) and (tick() - lastSawSearch) or elapsed

			if lastSawSearch > 0 and sinceSearch < 12 then
				task.wait(1)
			elseif lastSawSearch == 0 and elapsed < 8 then
				if not joinErrChecked and elapsed >= 1.0 and elapsed <= 5 and hasJoinErrorToast() then
					joinErrChecked = true
										task.wait(3)
					return false
				end
				task.wait(0.4)
			else
								return false
			end
		end
	end

	return isInMatch()
end

local function autoQueueLoop()
	-- AutoQueue silent start

	while AutoQueueState.Running and Core.Settings.AutoQueue do
		local ok, err = pcall(function()
			-- 게임 중이면 큐 완전 정지 + 전투/렌더 ON
			if isInMatch() or not canRunAutoQueue() then
				AutoQueueState.Phase = "ingame"
				if isInMatch() then
					pcall(function()
						local fn = getgenv()._SalboEnableMatchFeatures
						if fn then fn() end
					end)
				end
				task.wait(3)
				return
			end

			if isQueueSearching() then
				waitForMatchOrQueue(90)
				return
			end

			local now = tick()
			if (AutoQueueState.LastAttempt or 0) > 0 and (now - AutoQueueState.LastAttempt) < 2 then
				task.wait(0.25)
				return
			end

			if not isModeMenuOpen() then
				local playBtn = findTextButtonExact("플레이", { preferSmall = false, contains = true })
				if not playBtn then
					playBtn = findTextButtonExact("play", { preferSmall = false, contains = true })
				end
				if playBtn then
					AutoQueueState.LastAttempt = tick()
					clickGui(playBtn)
					for _ = 1, 20 do
						if not AutoQueueState.Running then return end
						if isInMatch() then return end
						if isModeMenuOpen() or isQueueSearching() then break end
						task.wait(0.2)
					end
				else
					task.wait(2)
				end
				return
			end

			local btn1 = findTextButtonExact("1v1", {
				preferSmall = true,
				skipBeginner = true,
				requirePath = "queuegamemodes",
			})
			if not btn1 then
				btn1 = findTextButtonExact("1v1", { preferSmall = true, skipBeginner = true })
			end
			if btn1 then
				AutoQueueState.LastAttempt = tick()
				clickGui(btn1)
				waitForMatchOrQueue(90)
				return
			end

			task.wait(1.2)
		end)

		if not ok then
			warn("[살보결] AutoQueue:", err)
			AutoQueueState.Lock = false
			task.wait(2)
		end
	end
	AutoQueueState.Running = false
	AutoQueueState.Thread = nil
	AutoQueueState.Lock = false
end

local function setAutoQueueEnabled(enabled)
	enabled = enabled and true or false

	if enabled then
		if AutoQueueState.Running then return end
	elseif not AutoQueueState.Running and not Core.Settings.AutoQueue then
		return
	end

	Core.Settings.AutoQueue = enabled
	Core:SaveSettings()

	AutoQueueState.Running = false
	task.wait(0.15)

	if enabled then
		Core.Settings.AutoReexec = true
		Core:SaveSettings()
		pcall(function()
			if setupAutoReexec then setupAutoReexec() end
		end)

		AutoQueueState.Running = true
		AutoQueueState.Phase = "play"
		Notify("Auto Queue", "켜짐 (플레이→1v1→대기→반복)")
		AutoQueueState.Thread = task.spawn(autoQueueLoop)
	else
		Notify("Auto Queue", "꺼짐")
	end
end

local function resolveScriptPath()
	local candidates = {
		Core.Settings.ScriptPath,
		"살보결 hub.lua",
		"MVSD/살보결 hub.lua",
		"살보결/살보결 hub.lua",
		"hub.lua",
		"MVSD/hub.lua",
	}
	if typeof(isfile) ~= "function" then return nil end
	for _, path in ipairs(candidates) do
		if path and path ~= "" and isfile(path) then
			return path
		end
	end
	return nil
end

local function getQueueOnTeleport()
	if typeof(queue_on_teleport) == "function" then return queue_on_teleport end
	if syn and typeof(syn.queue_on_teleport) == "function" then return syn.queue_on_teleport end
	if fluxus and typeof(fluxus.queue_on_teleport) == "function" then return fluxus.queue_on_teleport end
	if typeof(queueonteleport) == "function" then return queueonteleport end
	return nil
end

local function saveHubFromClipboard()
	if typeof(writefile) ~= "function" then
		return false, "writefile 없음"
	end
	local clip = nil
	pcall(function()
		if typeof(getclipboard) == "function" then
			clip = getclipboard()
		elseif typeof(toclipboard) == "function" then
			-- no read
		end
	end)
	if type(clip) ~= "string" or #clip < 800 then
		return false, "클립보드에 스크립트 전체를 복사하세요"
	end
	local looksLikeHub = string.find(clip, "AutoQueue", 1, true)
		or string.find(clip, "살보결", 1, true)
		or string.find(clip, "AddWindow", 1, true)
	if not looksLikeHub then
		return false, "클립보드 내용이 hub 스크립트가 아닌 것 같습니다"
	end
	local path = tostring(Core.Settings.ScriptPath or "살보결 hub.lua")
	if path == "" then path = "살보결 hub.lua" end
	local ok, err = pcall(writefile, path, clip)
	if not ok then return false, err end
	-- also mirror under MVSD
	pcall(function()
		Core:EnsureConfigFolder()
		writefile("MVSD/살보결 hub.lua", clip)
	end)
	return true, path
end

setupAutoReexec = function()
	if not Core.Settings.AutoReexec then return false, "disabled" end
	local queueFn = getQueueOnTeleport()
	if not queueFn then return false, "executor missing queue_on_teleport" end

	local path = resolveScriptPath()
	Core.Settings.ScriptUrl = "https://raw.githubusercontent.com/deltosh/test/refs/heads/main/d.lua"
	local url = tostring(Core.Settings.ScriptUrl or ""):gsub("^%s+", ""):gsub("%s+$", "")
	local payload
	local used

	-- URL 우선 (workspace 파일 불필요)
	if url ~= "" and (string.find(url, "http://", 1, true) == 1 or string.find(url, "https://", 1, true) == 1) then
		payload = string.format([[
task.spawn(function()
	local url = %q
	local ok, err = pcall(function()
		loadstring(game:HttpGet(url))()
	end)
	if not ok then
		warn("[살보결] auto reexec HttpGet failed:", err)
	end
end)
]], url)
		used = url
	elseif path then
		payload = string.format([[
task.spawn(function()
	local path = %q
	local ok, err = pcall(function()
		loadstring(readfile(path))()
	end)
	if not ok then
		warn("[살보결] auto reexec failed:", err)
	end
end)
]], path)
		used = path
	elseif getgenv()._SalboHubSource and type(getgenv()._SalboHubSource) == "string" and #getgenv()._SalboHubSource > 100 then
		payload = getgenv()._SalboHubSource
		used = "embedded"
	else
		return false, "reexec url/파일 없음"
	end

	local ok, err = pcall(queueFn, payload)
	if not ok then return false, err end
	return true, used
end

-- Load persisted auto settings early
pcall(function()
	Core:LoadSettings()
end)

AutoQueueToggle = sections.settings_right:AddToggle({
	name = "Auto Queue 1v1",
	default = Core.Settings.AutoQueue,
	callback = function(enabled)
		-- 매칭 대기 중 실수 클릭/오클릭으로 꺼지는 것 방지
		if AutoQueueState and AutoQueueState.Lock then
			if not enabled and AutoQueueToggle and AutoQueueToggle.UpdateState then
				task.defer(function()
					AutoQueueToggle:UpdateState(true, false)
				end)
			end
			return
		end
		setAutoQueueEnabled(enabled)
	end,
})

sections.settings_right:AddToggle({
	name = "Auto Reexec (맵 이동)",
	default = Core.Settings.AutoReexec,
	callback = function(enabled)
		Core.Settings.AutoReexec = enabled and true or false
		Core:SaveSettings()
		if enabled then
			local ok, info = setupAutoReexec()
			if ok then
				Notify("Auto Reexec", "등록됨: " .. tostring(info))
			else
				Notify("Auto Reexec", "실패: " .. tostring(info))
			end
		else
			Notify("Auto Reexec", "꺼짐 (다음 이동부터)")
		end
	end,
})

sections.settings_right:AddButton({
	name = "register reexec now",
	callback = function()
		Core.Settings.AutoReexec = true
		if not Core.Settings.ScriptPath or Core.Settings.ScriptPath == "" then
			Core.Settings.ScriptPath = "살보결 hub.lua"
		end
		Core:SaveSettings()
		local ok, info = setupAutoReexec()
		if ok then
			Notify("Auto Reexec", "등록됨: " .. tostring(info))
		else
			Notify("Auto Reexec", "실패: " .. tostring(info))
		end
	end,
})

-- Startup: reexec + autoload + autoqueue + 매치 입장 시 전투/렌더 자동 ON
local function forceToggleOn(toggle)
	if not toggle or not toggle.UpdateState then return end
	pcall(function()
		toggle:UpdateState(false, true)
		toggle:UpdateState(true, true)
	end)
end

local function enableMatchFeatures()
	-- Render 서브옵션 먼저 (PlayerESP 생성 시 값 반영)
	Core.Features.PlayerESP.Box = true
	Core.Features.PlayerESP.Tracer = true
	Core.Features.PlayerESP.Skeleton = true
	Core.Features.PlayerESP.Arrows = true
	Core.Features.PlayerESP.Name = true
	Core.Features.PlayerESP.RemoveHiddenCharacters = true

	forceToggleOn(ESPBox)
	forceToggleOn(ESPTracer)
	forceToggleOn(ESPSkeleton)
	forceToggleOn(ESPArrows)
	forceToggleOn(ESPName)
	forceToggleOn(ESPRemoveHidden)
	forceToggleOn(PlayerESP)
	forceToggleOn(Aura)

	forceToggleOn(SpinBot)
	forceToggleOn(KillAll)

	print("[살보결] Match features ON KillAll=", Core.Connections.KillAll ~= nil,
		"SpinBot=", Core.Connections.SpinBot ~= nil,
		"ESP=", EspInstance ~= nil)
end

getgenv()._SalboEnableMatchFeatures = enableMatchFeatures

local MatchFeatureState = {
	WasInMatch = false,
	LastEnable = 0,
}

local function onMaybeEnteredMatch(reason)
	-- 자동매치(Auto Queue) 켰을 때만 KillAll/Spin/Render 자동 ON
	if not Core.Settings.AutoQueue then
		return
	end
	if not isInMatch() then
		MatchFeatureState.WasInMatch = false
		return
	end
	local now = tick()
	-- 같은 매치에서 0.8초 안 중복 방지
	if MatchFeatureState.WasInMatch and (now - MatchFeatureState.LastEnable) < 0.8 then
		return
	end
	local firstEnter = not MatchFeatureState.WasInMatch
	MatchFeatureState.WasInMatch = true
	if not firstEnter and (now - MatchFeatureState.LastEnable) < 2 then
		return
	end
	MatchFeatureState.LastEnable = now
	print("[살보결] Match enter:", reason or "?")
	task.defer(function()
		task.wait(0.35)
		enableMatchFeatures()
		task.wait(0.8)
		if isInMatch() then
			enableMatchFeatures()
		end
	end)
end

local function startMatchFeatureWatcher()
	pcall(function()
		LocalPlayer:GetAttributeChangedSignal("Match"):Connect(function()
			task.wait(0.2)
			onMaybeEnteredMatch("MatchAttr")
		end)
	end)

	task.spawn(function()
		while true do
			local inMatch = false
			pcall(function()
				inMatch = isInMatch()
			end)
			if inMatch then
				onMaybeEnteredMatch("poll")
			else
				MatchFeatureState.WasInMatch = false
			end
			task.wait(1.25)
		end
	end)

	-- 이미 매치 중이면 즉시
	task.defer(function()
		task.wait(1)
		onMaybeEnteredMatch("startup")
	end)
end

task.defer(function()
	if Core.Settings.AutoReexec then
		local ok, info = setupAutoReexec()
		if ok then
			print("[살보결] Auto Reexec queued:", info)
		else
			print("[살보결] Auto Reexec skip:", info)
		end
	end

	startMatchFeatureWatcher()

	if Core.Settings.AutoQueue then
		setAutoQueueEnabled(true)
	end
end)

local function cleanup()
	if getgenv()._SalboCleaning then return end
	getgenv()._SalboCleaning = true

	if EspInstance then
		pcall(function()
			EspInstance:Disable()
		end)
		EspInstance = nil
	end

	pcall(destroyAura)

	if Core.Features and Core.Features.NoFog and Core.Features.NoFog.Enabled then
		pcall(function()
			setNoFogEnabled(false)
		end)
	end

	if NotifyGui then
		pcall(function()
			NotifyGui:Destroy()
		end)
		NotifyGui = nil
	end

	if Core.Features and Core.Features.SilentAim and Core.Features.SilentAim.Hook then
		pcall(function()
			hookmetamethod(game, "__namecall", Core.Features.SilentAim.Hook)
		end)
		Core.Features.SilentAim.Hook = nil
	end

	for _, connection in next, Core.Connections do
		if connection and connection.Disconnect then
			pcall(function()
				connection:Disconnect()
			end)
		end
	end
	Core.Connections = {}

	if getgenv()._OdysseyUnload then
		pcall(getgenv()._OdysseyUnload)
	end

	getgenv()._SalboCleanup = nil
	getgenv()._OdysseyUnload = nil
	getgenv().Core = nil
	getgenv()._SalboCleaning = nil
end

Core.Unload = cleanup
getgenv()._SalboCleanup = cleanup

Services.UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Delete then
		cleanup()
	end
end)

print("Script Loading .....")
