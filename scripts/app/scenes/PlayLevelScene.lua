
local Levels = import("..data.Levels")
local Board = import("..views.Board")
local AdBar = import("..views.AdBar")
local BubbleButton = import("..views.BubbleButton")

local PlayLevelScene = class("PlayLevelScene", function()
    return display.newScene("PlayLevelScene")
end)

function PlayLevelScene:ctor(levelIndex)
    self.levelIndex = levelIndex
    self.hasShowResult = false
    local bg = display.newSprite("dota/bg/bg4.jpg")
    -- make background sprite always align top
    bg:setPosition(display.cx, display.cy)
    self:addChild(bg)

    local param = {color =cc.c4f(0.5,0.5,0.5,0.5),fill = true}
    local size = bg:getContentSize()
    local mask = display.newRect(cc.rect(display.cx,display.cy,size.width,size.height),param)
    self:addChild(mask)
    GameManager.autoScale(bg)
    GameManager.autoScale(mask)
    -- local title = display.newSprite("#Title.png", display.left + 150, display.top - 50)
    -- title:setScale(0.5)
    -- self:addChild(title)

    -- local adBar = AdBar.new()
    -- self:addChild(adBar)

    local label = ui.newBMFontLabel({
        text  = string.format("Level: %s", tostring(levelIndex)),
        font  = "UIFont.fnt",
        x     = display.cx,
        y     = display.top - display.height/6,
        align = ui.TEXT_ALIGN_CENTER,
    })

    self:addChild(label)

    self.board = Board.new(Levels.get(levelIndex))
    self.board:addEventListener("LEVEL_COMPLETED", handler(self, self.onNewHero))
    self:addChild(self.board)

    -- create menu
    local backButton = BubbleButton.new({
        image = "#back.png",
        x = display.right - display.width/6,
        y = display.bottom + display.height/10,
        sound = GAME_SFX.backButton,
        listener = function()
            app:enterChooseLevelScene()
        end,
    })

    local freshButton = BubbleButton.new({
        image = "#fresh.png",
        x = display.left + display.width/6,
        y = display.bottom + display.height/10,
        sound = GAME_SFX.backButton,
        listener = function()
            app:playLevel(GameManager.currentPass)
        end,
    })

    local nextButton = BubbleButton.new({
        image = "#next.png",
        x = display.cx ,
        y = display.bottom + display.height/10,
        sound = GAME_SFX.backButton,
        listener = function()
            app:playLevel(GameManager.currentPass+1)
        end,
    })

    local menu = ui.newMenu({backButton,freshButton,nextButton})
    self:addChild(menu)
end

function PlayLevelScene:onNewHero( )
    audio.playSound(GAME_SFX.success)
    local path = string.format("dota/%d.jpg",GameManager.currentPass)
    self.image = BubbleButton.new({
        image = path,
        x = display.cx,
        y = display.top + 40,
        sound = GAME_SFX.backButton,
        prepare = function()
            self.menuMap:setEnabled(false)
        end,
        listener = function()
            -- self.menuMap:setVisible(false)
            self:onLevelCompleted()
        end,
    })
    self.image:setScale(0.5)
    self.menuMap = ui.newMenu({self.image})
    self:addChild(self.menuMap)

    transition.moveTo(self.image, {time = 0.7, y = display.cy, easing = "BOUNCEOUT"})

end

function PlayLevelScene:onLevelCompleted()
    if self.hasShowResult then
        return
    end
    self.hasShowResult = true
     audio.playSound(GAME_SFX.backButton)
    -- local dialog = BubbleButton.new({
    --     image = "dota/success.jpg",
    --     x = display.cx,
    --     y = display.top + 40,
    --     sound = GAME_SFX.backButton,
    --     prepare = function()
    --         self.menu:setEnabled(false)
    --     end,
    --     listener = function()
    --         app:playLevel(GameManager.currentPass+1)
    --     end,
    -- })
    local label = ui.newBMFontLabel({
        text  = string.format("Success!\nNext Level is Level %s", tostring(self.levelIndex+1)),
        font  = "UIFont.fnt",
        x     = display.cx,
        y     = display.top + 40,
        align = ui.TEXT_ALIGN_CENTER,
    })
    if Levels.numLevels() >= self.levelIndex+1 then
        self:addChild(label)
        label:setZOrder(100)
        transition.moveTo(label, {time = 1.0, y = display.cy, easing = "BOUNCEOUT"})
    end


    -- local buttonSize = dialog:getContentSize()

    -- local ttfLebel = ui.newTTFLabel({
    --     text = "成功收集英雄!点击继续下一关!",
    --     size = 20,
    --     teztAlign = ui.TEXT_ALIGN_CENTER,
    --     x = buttonSize.width/2,
    --     y = buttonSize.height/2
    --     })
    -- print("==ttfLabel===",ttfLabel)
    -- dialog:addChild(ttfLabel)
    
    -- self.menu = ui.newMenu({dialog})
    -- self:addChild(self.menu)

    -- transition.moveTo(dialog, {time = 0.7, y = display.cy, easing = "BOUNCEOUT"})
    GameManager.saveGameData( self.levelIndex,1)
    GameManager.showSpotView( )
end

function PlayLevelScene:onEnter()
    audio.preloadSound(GAME_SFX.backButton)
    audio.preloadSound(GAME_SFX.Avatar)
    local music = {
        GAME_SFX.bgMusic1,
        GAME_SFX.bgMusic2,
        GAME_SFX.bgMusic3,
        GAME_SFX.bgMusic4,
        GAME_SFX.bgMusic5,
    }
    local index = math.random(1,5)
    GameManager.playBgMusic(music[index])
end

function PlayLevelScene:onExit( ... )
    audio.unloadSound(GAME_SFX.backButton)
    audio.unloadSound(GAME_SFX.Avatar)
end

return PlayLevelScene
