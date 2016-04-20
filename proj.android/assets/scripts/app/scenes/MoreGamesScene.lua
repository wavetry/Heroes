
local AdBar = import("..views.AdBar")
local BubbleButton = import("..views.BubbleButton")

local MoreGamesScene = class("MoreGamesScene", function()
    return display.newScene("MoreGamesScene")
end)

function MoreGamesScene:ctor()
    bg = display.newSprite("dota/bg/bg5.jpg", display.cx, display.cy)
    self:addChild(bg)

    local param = {color =cc.c4f(0,0,0,0.5),fill = true}
    local size = bg:getContentSize()
    local mask = display.newRect(cc.rect(display.cx,display.cy,size.width,size.height),param)
    self:addChild(mask)
    GameManager.autoScale(bg)
    GameManager.autoScale(mask)


    -- self.adBar = AdBar.new()
    -- self:addChild(self.adBar)

    local backButton = BubbleButton.new({
        image = "#back.png",
        x = display.right - display.width/6,
        y = display.bottom + display.height/10,
        sound = GAME_SFX.backButton,
        listener = function()
            app:enterMenuScene()
        end
    })

    local menu = ui.newMenu({backButton})
    self:addChild(menu)
end
function MoreGamesScene:onEnter()
    audio.preloadSound(GAME_SFX.backButton)
   GameManager.playBgMusic(GAME_SFX.bgMusic4)
end

function MoreGamesScene:onExit()
    audio.unloadSound(GAME_SFX.backButton)
end

return MoreGamesScene
