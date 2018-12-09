--cold hand
--textMenuSystem
--copyright Hampus Huledal

local menuSystem = {}

menuSystem.menues = {}
menuSystem.stack = {}
menuSystem.stack.top = 0
menuSystem.stack.content = {}

---------------------------------------------------------------------------------

--style
menuSystem.style = {}
menuSystem.style.cursor = "<<<"
menuSystem.style.bodySize = 12
menuSystem.style.bodyXOffset = 20
menuSystem.style.headerSize = 20
menuSystem.style.HeaderDivide = 5
menuSystem.style.textColor = { 1, 1, 0, 1}

--------------------------------------------------------------------------------

function menuSystem.stack:getTop()
    if self.top == 0 then 
        print("top is zero")
        return nil 
    else
        return self.content[self.top]
    end
end

--------------------------------------------------------------------------------

function menuSystem.stack:pop()
    local reutrnValue = self.content[self.top]
    if self.top > 0 then self.top = self.top - 1 end
    return reutrnValue
end

--------------------------------------------------------------------------------

function menuSystem.stack:push(anObject)
    self.top = self.top + 1
    self.content[self.top] = anObject
end

--------------------------------------------------------------------------------

--Create a new menu from an object and add it to the top oft the menu stack
--arg 1, name: the name of the new menu displayed at the top
--arg 2, menuTable: the table used to create the menu, the keys are displayed and depending on the type of the value it will act in different ways, 
--  If it is a function that function will run if selected, where the arguments are the table and the menu system
--  If it is a string or a number the user can change the value when it's selected
--  If it is a table it will be pushed to the menu stack as a new menu
--if it's array is populated with the keys that will be used to sort the menu, if there is a sorting only the keys in the sorting will be used
--arg 3, x position to draw the menu
--arg 4, y position to draw the menu
--arg 5(optional), a bool deciding weather it should draw the menu below on the stack also
function menuSystem:CreateNewMenu(name, menuTable, x, y, letThrough)
    assert(type(name) == "string", "TXTM1: TextMenuSystem ERROR menu name need to be string")
    assert(type(menuTable) == "table", "TXTM2: TextMenuSystem ERROR second argument should be a table with data and functions that will represent the menu, and use the array to order it")
    letThrough = letThrough or false

    local menu = {}

    if #menuTable == 0 
    then
        local count = 0;
        for key, value in pairs(menuTable)
        do
            menuTable[count] = key
            count = count + 1
        end
    end

    menu.size = #menuTable

    menu.menuTable = menuTable
    menu.position = { x = x, y = y}
    menu.cursor = 1
    menu.letThrough = letThrough;
    menu.name = name

    self.stack:push(menu)
    return
end

--------------------------------------------------------------------------------

function menuSystem:getTopOfMenuStack()
    return self.stack:getTop()
end

--------------------------------------------------------------------------------

function menuSystem:popMenu()
    return menuSystem.stack:pop()
end

--------------------------------------------------------------------------------

function menuSystem:Draw(offset)
    if self.stack.top < 1 then return end
    offset = offset or 0

    assert(offset < self.stack.top, "TXTM3: offset is larger than ammount of menues, can't draw negative menues")

    local currentMenu = self.stack.content[self.stack.top - offset]
    if currentMenu.letThrough and self.stack.top - offset > 0 
    then 
        self:draw(offset + 1) 
    end

    if self.style.headerFont == nil 
    then
        self.style.headerFont = love.graphics.newFont(self.style.headerSize)
    end

    love.graphics.setColor(self.style.textColor)
    love.graphics.setFont(self.style.headerFont)

    local currentPosition = { x = currentMenu.position.x, y = currentMenu.position.y}

    love.graphics.print(currentMenu.name, currentPosition.x, currentPosition.y)

    currentPosition.y = currentPosition.y + self.style.headerFont:getAscent() + self.style.HeaderDivide
    currentPosition.x = currentPosition.x + self.style.bodyXOffset

    if #currentMenu > 0 
    then
        for index, key in ipairs(currentMenu.menuTable) 
        do
            if currentMenu.menuTable[key] == nil then break end

            local outputString = ""
            outputString = outputString .. index .. ". "
            
            outputString = outputString .. key

            local currentValue = currentMenu.menuTable[key]
            if type(currentValue) == "number" or type(currentValue) == "string" 
            then
                outputString = outputString .. " : " .. currentValue
            end

            if index == currentMenu.cursor 
            then
                outputString = outputString .. " " .. self.style.cursor;
            end

            self:WritrLine(outputString, currentPosition.x, currentPosition.y, index)
        end
    end

    love.graphics.setColor( 1, 1, 1, 1)
end

--------------------------------------------------------------------------------

function menuSystem:WriteLine(aText, aX, aY, aLine)
    if self.style.bodyFont == nil 
    then
        self.style.bodyFont = love.graphics.newFont(self.style.bodySize)
    end
    love.graphics.setFont(self.style.bodyFont)

    local y = aY + self.style.bodyFont:getAscent() * (aLine - 1)

    love.graphics.print(aText, aX, y)
end

--------------------------------------------------------------------------------

function menuSystem:Up()
    local currentMenu = self:getTopOfMenuStack()

    currentMenu.cursor = currentMenu.cursor - 1

    if currentMenu.cursor < 1 
    then
        currentMenu.cursor = currentMenu.size
    end
end

--------------------------------------------------------------------------------

function menuSystem:Down()
    local currentMenu = self:getTopOfMenuStack()

    currentMenu.cursor = currentMenu.cursor + 1

    if currentMenu.cursor >  currentMenu.size
    then
        currentMenu.cursor = 1
    end
end

--------------------------------------------------------------------------------

function menuSystem:Activate()
    local currentMenu = self:getTopOfMenuStack()

    local currentEntry = currentMenu.menuTable[currentMenu.menuTable[currentMenu.cursor]]

    if type(currentEntry) == "function"
    then
        currentEntry()
    end
end

--------------------------------------------------------------------------------

return menuSystem