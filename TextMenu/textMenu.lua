--cold hand
--copyright Hampus Huledal

local menuSystem = {}

menuSystem.menues = {}
menuSystem.stack = {}
menuSystem.stack.top = 0
menuSystem.stack.content = {}

function menuSystem.stack:getTop()
    if self.top == 0 then 
        return nil 
    else
        return self.content[top]
    end
end

function menuSystem:CreateNewMenu(name, functions, x, y, letThrough)
    assert(type(name) == string, "TXTM1: TextMenuSystem ERROR menu name need to be string")
    assert(type(functions) == table, "TXTM2: TextMenuSystem ERROR functions should be a table of functions where the key is the text to display")
    if letThrough ==  nil then letThrough = true end

    local menu = {}

    menu.functions = functions
    menu.position = { x = x, y = y}
    menu.cursor = 1
    menu.letThrough = true;

    self.menues[name] = menu
    menuSystem.stack.top = menuSystem.stack.top + 1
    menuSystem.stack.content[top] = name
    return
end

function menuSystem:getTopOfMenuStack()
    local name = menuSystem:getTop()
    if name == nil then
        return nil
    else
        return self.menues[name]
    end
end

function menuSystem:popMenu()

end