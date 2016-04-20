
local AdBar = import("..views.AdBar")
local BubbleButton = import("..views.BubbleButton")
local Segment = import("..views.Segment")
local MenuScene = class("MenuScene", function()
    return display.newScene("MenuScene")
end)

function MenuScene:ctor()
    local bg = display.newSprite("dota/bg/bg3.jpg", display.cx, display.cy)
    self:addChild(bg)
    
    local param = {color =cc.c4f(0,0,0,0.5),fill = true}
    local size = bg:getContentSize()
    local mask = display.newRect(cc.rect(display.cx,display.cy,size.width,size.height),param)
    mask:setScale(display.height/bg:getContentSize().height)
    self:addChild(mask)
    GameManager.autoScale(bg)
    GameManager.autoScale(mask)
    -- self.adBar = AdBar.new()
    -- self:addChild(self.adBar)

    local name = ui.newTTFLabel({
        text = "刀塔英雄",
        -- font = "",
        size = 128,
        align = ui.TEXT_ALIGN_CENTER,
        valign = ui.TEXT_VALIGN_TOP,
        })
    name:setPosition(display.cx,display.cy)
    self:addChild(name)
    -- create menu
    self.moreGamesButton = BubbleButton.new({
        image = "#about.png",
        x = display.left + display.width/4,
        y = display.bottom + display.height/4,
        sound = GAME_SFX.tapButton,
        prepare = function()
            self.menu:setEnabled(false)
        end,
        listener = function()
            app:enterGalleryScene()
        end,
    })


    self.startButton = BubbleButton.new({
        image = "#fight.png",
        x = display.right - display.width/4,
        y = display.bottom + display.height/4,
        sound = GAME_SFX.tapButton,
        prepare = function()
            self.menu:setEnabled(false)
        end,
        listener = function()
            app:enterChooseLevelScene()
        end,
    })

    self.menu = ui.newMenu({self.moreGamesButton, self.startButton})
    self:addChild(self.menu)
    
end

function MenuScene:onEnter()
    audio.preloadSound(GAME_SFX.tapButton)
    GameManager.playBgMusic(GAME_SFX.bgMusic1)
end

function MenuScene:onExit()
    audio.unloadSound(GAME_SFX.tapButton)
end

return MenuScene
