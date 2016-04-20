
local AdBar = import("..views.AdBar")
local BubbleButton = import("..views.BubbleButton")
local LevelsList = import("..views.LevelsList")

local ChooseLevelScene = class("ChooseLevelScene", function()
    return display.newScene("ChooseLevelScene")
end)

function ChooseLevelScene:ctor()
    local bg = display.newSprite("dota/bg/bg1.jpg")
    -- make background sprite always align top
    bg:setPosition(display.cx, display.cy )
    self:addChild(bg)

    local param = {color =cc.c4f(0,0,0,0.4),fill = true}
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
    local rect = CCRect(display.left, display.bottom + display.height/8, display.width, display.height/4*3)
    self.levelsList = LevelsList.new(rect)
    self.levelsList:addEventListener("onTapLevelIcon", handler(self, self.onTapLevelIcon))
    self:addChild(self.levelsList)

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

function ChooseLevelScene:onTapLevelIcon(event)
    audio.playSound(GAME_SFX.tapButton)
    app:playLevel(event.levelIndex)
end

function ChooseLevelScene:onEnter()
    audio.preloadSound(GAME_SFX.backButton)
    audio.preloadSound(GAME_SFX.tapButton)
    GameManager.playBgMusic(GAME_SFX.bgMusic4)
    self.levelsList:setTouchEnabled(true)
    self.levelsList:setCurrentIndex(GameManager.currentIndex)
end
function ChooseLevelScene:onExit()
    audio.unloadSound(GAME_SFX.tapButton)
    audio.unloadSound(GAME_SFX.backButton)
end


return ChooseLevelScene
