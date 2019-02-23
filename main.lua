--cold hand
--copyright Hampus Huledal

local menuSystem = assert(require("TextMenu.textMenu"), "could not find TextMenu/texMenu.lua")
local miscUtil = assert(require("Util.miscUtil"), "could not find Util.miscUtil.lua")

function love.load(args, uargs)
    print("load")

    print("Cold Hand started \n Copyright Hampus Huledal, heeelo")
    print("Args: ")
    --parse args and make table readonly
    --TODO: add better parsing taking arguments and checking for more
    local parsedArgs = {}
    for index, value in ipairs(args) 
    do
        print(index .. ": " .. value)
        parsedArgs[value] = true;  
    end
    global_Args = miscUtil.makeReadOnly(parsedArgs)
    
    --This is if you are using visual studio code and want to debug your code using the Lua Debugger(https://marketplace.visualstudio.com/items?itemName=devCAT.lua-debug).
    if global_Args["-VSCodeDebug"]
    then
        local json = require 'Json.dkjson'
        local global_Debuggee = require 'Debugging.vscode-debuggee'
        local startResult, breakerType = global_Debuggee.start(json)
        print('debuggee start ->', startResult, breakerType)
    end

    local menuTable = {}
    menuTable.testText = "test"
    menuTable.testNumber = 42
    menuTable.testFunctionQuit = function()
        love.event.quit()
    end

    menuSystem:CreateNewMenu("testMenu", menuTable, 100, 100, false)
end

function love.update(deltaTime)
    if global_Debuggee then global_Debuggee.poll() end
end

function love.keypressed(key, scancode, isrepeat )
    if key == "up"
    then
        menuSystem:Up()
    elseif key == "down"
    then
        menuSystem:Down()
    elseif key == "return"
    then
        menuSystem:Activate()
    end
end

function love.textinput(text)
    --menuSystem:Input(text)
end

function love.draw()
    menuSystem:Draw()
end
