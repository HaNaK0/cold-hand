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