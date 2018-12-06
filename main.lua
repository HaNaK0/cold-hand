--cold hand
--copyright Hampus Huledal

local menuSystem = require("TextMenu.textMenu")

function love.load(args)
    print("load")

    local menuTable = {}
    menuTable.testText = "test"
    menuTable.testNumber = 42
    menuTable.testFunctionQuit = function()
        love.event.quit()
    end

    menuSystem:CreateNewMenu("testMenu", menuTable, 100, 100, false)
function love.load(args, uargs)
    print("Cold Hand started \n copyright Hampus Huledal")
    print("Args: ")
    --parse args
    --TODO: add better parsing taking arguments and checking for more
    local parsedArgs = {}
    for index, value in ipairs(args) 
    do
        print(index .. ": " .. value)
        parsedArgs[value] = true;  
    end
    
    --This is if you are using visual studio code and want to debug your code using the Lua Debugger(https://marketplace.visualstudio.com/items?itemName=devCAT.lua-debug).
    if parsedArgs["-VSCodeDebug"] 
    then
        local json = require 'Json.dkjson'
        local debuggee = require 'Debugging.vscode-debuggee'
        local startResult, breakerType = debuggee.start(json)
        print('debuggee start ->', startResult, breakerType)
    end

    print("testing debug")
end

function love.update(deltaTime)
end

function love.keypressed(key, scancode, isrepeat )
    if key == "up"
    then
        menuSystem:Up()
    elseif key == "down"
    then
        menuSystem:Down()
    end
end

function love.draw()
    menuSystem:Draw()
end