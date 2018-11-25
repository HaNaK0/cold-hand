--cold hand
--copyright Hampus Huledal

local SpriteUtil = {}

function SpriteUtil.LoadSheet(anImagePath, aSheetDataPath)
    local sheetDataPath = aSheetDataPath;
    local imagePath = anImagePath
    if sheetDataPath == nil
    then
        sheetDataPath = imagePath .. ".lua"
    end

    assert(sheetDataPath, "SL1: [SpriteUtil.LoadSheet] Did not manage to create a sprite sheet path!, Did you send in both arguments as nil?")
    local sheetData = dofile(sheetDataPath)
    assert(sheetData, "SL3: [SpriteUtil.LoadSheet] Something wrong with the sheet file")

    if sheetData.path ~= nil
    then
        imagePath = sheetData.path
    end

    assert(imagePath, "SL2: [SpriteUtil.LoadSheet] Did not get a image path! there were non sent to function and sheet file did not contain one")
    local image = love.graphics.newImage(anImagePath)

    local sprites = {}

    for i, spriteInfo in ipairs(sheetData.sprites) 
    do
        local quad = love.graphics.newQuad(spriteInfo.x, spriteInfo.y, spriteInfo.width, spriteInfo.height, image:getDimensions())
        sprites[i] = {drawable = image, quad = quad, spriteInfo = spriteInfo, Draw = SpriteUtil.RenderSprite}
        assert(spriteInfo.name , "SL4: [SpriteUtil.LoadSheet] Sprite info is missing name")
        sprites[spriteInfo.name] = sprites[i]
    end

    return sprites;
end

function SpriteUtil.RenderSprite(aSprite, aX, aY)
    assert(aSprite and aX and aY, "SR1: [SpriteUtil.RenderSprite] missing arguments")
    love.graphics.draw(aSprite.drawable, aSprite.quad, aX, aY)
end

return SpriteUtil