
local ScrollViewCell = import("..ui.ScrollViewCell")
local LevelsListCell = class("LevelsListCell", ScrollViewCell)

function LevelsListCell:ctor(size, beginLevelIndex, endLevelIndex, rows, cols)
    local rowHeight = math.floor((display.height - 340) / rows)
    local colWidth = math.floor(display.width * 0.9 / cols)

    local node = display.newNode()
    self:addChild(node)
    self.pageIndex = pageIndex
    self.buttons = {}

    local startX = (display.width - colWidth * (cols - 1)) / 2
    local y = display.top - 220
    local levelIndex = beginLevelIndex

    for row = 1, rows do
        local x = startX
        for column = 1, cols do
            local path = self:getIconPath(levelIndex)
            local icon = display.newSprite(path, x, y)
            node:addChild(icon)
            icon.levelIndex = levelIndex
            self.buttons[#self.buttons + 1] = icon

            local label = ui.newBMFontLabel({
                text  = tostring(levelIndex),
                font  = "UIFont.fnt",
                x     = x,
                y     = y - 4,
                align = ui.TEXT_ALIGEN_CENTER,
            })
            self:addChild(label)

            x = x + colWidth
            levelIndex = levelIndex + 1
            if levelIndex > endLevelIndex then break end
        end

        y = y - rowHeight
        if levelIndex > endLevelIndex then break end
    end

    -- add highlight level icon
    -- self.highlightButton = display.newSprite("#HighlightLevelIcon.png")
    -- self.highlightButton:setVisible(false)
    -- self:addChild(self.highlightButton)
end

function LevelsListCell:getIconPath( levelIndex )
   if LockData[levelIndex] == 1 then
        return "#done.png"
    else
        return "#undone.png"

   end
end


function LevelsListCell:onTap(x, y)
    local button = self:checkButton(x, y)
    if button then
        self:dispatchEvent({name = "onTapLevelIcon", levelIndex = button.levelIndex})
    end
end

function LevelsListCell:checkButton(x, y)
    local pos = CCPoint(x, y)
    for i = 1, #self.buttons do
        local button = self.buttons[i]
        if button:getBoundingBox():containsPoint(pos) then
            return button
        end
    end
    return nil
end

function LevelsListCell:onTouch(event, x, y)
    if event == "began" then
        local button = self:checkButton(x, y)
        if button then
            -- self.highlightButton:setVisible(true)
            -- self.highlightButton:setPosition(button:getPosition())
        end
    elseif event ~= "moved" then
        -- self.highlightButton:setVisible(false)
    end
end

function LevelsListCell:getBtns(  )
    return self.buttons
end


return LevelsListCell
