--A small wrapper for xml2lua
--Written by Hampus Huledal

local xml2lua = globals.Utils.AssertRequire("External.XML.xml2lua-master.xml2lua")
local xmlTree = globals.Utils.AssertRequire("External.XML.xml2lua-master.xmlhandler.tree")

local wrapper = {}

function wrapper.parseToTree(path)
    assert(path, "path is nil, should be a string")

    local handlerTree = xmlTree:new()
    local parser = xml2lua.parser(handlerTree)
    parser:parse(xml2lua.loadFile(path))
    
    xml2lua.printable(handlerTree.root)

    return handlerTree
end

return wrapper