--
-- Author: deadline
-- Date: 2016-03-09 15:05:49
--
local ScrollViewCell = import("..ui.ScrollViewCell")
local GalleryMap = import(".GalleryMap")
local GalleryListCell = class("GalleryListCell",ScrollViewCell)

function GalleryListCell:ctor( size, beginLevelIndex, endLevelIndex, rows, cols)
	local rowHeight = math.floor((display.height /4 * 3) / rows)
    local colWidth = math.floor(display.width * 0.9 / cols)
    local node = display.newNode()
    self:addChild(node)

    self.pageIndex = pageIndex
    self.buttons = {}
    local UnLockData = GameManager.getUnLockData()
    local startX = (display.width - colWidth * (cols - 1)) / 2
    local y = display.height/4*3
    local index = beginLevelIndex
    local levelIndex = UnLockData[index]

    for row  = 1, rows do
    	local x = startX
    	for column = 1, cols do
    		if index > endLevelIndex then break end
    		local icon = GalleryMap.new(levelIndex,x,y)
    		icon:setPosition(x, y)
    		node:addChild(icon)
    		icon.levelIndex = levelIndex
    		self.buttons[#self.buttons + 1] = icon

    		x = x + colWidth
    		index = index + 1
    		levelIndex = UnLockData[index]
    		
    	end

    	y = y - rowHeight
    	if index > index then break end
    end

    -- self.highlightButton = display.newSprite("#HighlightLevelIcon.png")
    -- self.highlightButton:setVisible(false)
    -- self:addChild(self.highlightButton)

end


function GalleryListCell:onTap(x, y)
    local button = self:checkButton(x, y)
    if button then
        self:dispatchEvent({name = "onTapLevelIcon", levelIndex = button.levelIndex})
    end
end

function GalleryListCell:checkButton(x, y)
    local pos = CCPoint(x, y)
    for i = 1, #self.buttons do
        local button = self.buttons[i]
        if button:getBoundingBox():containsPoint(pos) then
            return button
        end
    end
    return nil
end

function GalleryListCell:onTouch(event, x, y)
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

return GalleryListCell