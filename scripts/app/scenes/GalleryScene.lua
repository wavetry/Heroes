
local AdBar = import("..views.AdBar")
local BubbleButton = import("..views.BubbleButton")
local GalleryList = import("..views.GalleryList")

local GalleryScene = class("GalleryScene", function()
    return display.newScene("GalleryScene")
end)

function GalleryScene:ctor()
    local bg = display.newSprite("dota/bg/bg2.jpg")
    -- make background sprite always align top
    bg:setPosition(display.cx, display.cy)
    self:addChild(bg)

    local param = {color =cc.c4f(0,0,0,0.5),fill = true}
    local size = bg:getContentSize()
    local mask = display.newRect(cc.rect(display.cx,display.cy,size.width,size.height),param)
    self:addChild(mask)
    GameManager.autoScale(bg)
    GameManager.autoScale(mask)
    -- local title = display.newSprite("#Title.png", display.cx, display.top - 100)
    -- self:addChild(title)

    -- local adBar = AdBar.new()
    -- self:addChild(adBar)

    -- create levels list
    local rect = CCRect(display.left, display.bottom + display.height/8, display.width, display.height /4*3)
    self.galleryList = GalleryList.new(rect)
    self:addChild(self.galleryList)

    -- create menu
    local backButton = BubbleButton.new({
        image = "#back.png",
        x = display.right - display.width/6,
        y = display.bottom + display.height/10,
        sound = GAME_SFX.backButton,
        listener = function()
            app:enterMenuScene()
            GameManager.currentIndex = 1
        end,
    })

    local menu = ui.newMenu({backButton})
    self:addChild(menu)
end

function GalleryScene:onEnter()
    audio.preloadSound(GAME_SFX.backButton)
	GameManager.playBgMusic(GAME_SFX.bgMusic3)
    self.galleryList:setTouchEnabled(true)
    self.galleryList:setCurrentIndex(1)
    GameManager.showSpotView( )
end

function GalleryScene:onExit()
    audio.unloadSound(GAME_SFX.backButton)
end

return GalleryScene
