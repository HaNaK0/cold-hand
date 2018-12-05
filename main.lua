--cold hand
--copyright Hampus Huledal

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

function love.draw()
    love.graphics.print("Hello World!", 400, 300)
end