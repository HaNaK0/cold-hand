local xml2lua = require("xml2lua-master.xml2lua")
local handler = require("xml2lua-master.xmlhandler.tree")

return xml2lua.parser(handler)