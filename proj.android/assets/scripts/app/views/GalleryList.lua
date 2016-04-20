--
-- Author: deadline
-- Date: 2016-03-09 15:05:31
--
local GalleryListCell = import(".GalleryListCell")
local Levels = import("..data.Levels")

local PageControl = import("..ui.PageControl")
local GalleryList = class("GalleryList", PageControl)
GalleryList.INDICATOR_MARGIN = 46

function GalleryList:ctor(rect)
	GalleryList.super.ctor(self,rect,PageControl.DIRECTION_HORIZONTAL)
	self.indicatorList = {}
	local rows,cols = 3,1
	if display.height > 1000 then rows = rows + 1 end
	local UnLockData = GameManager.getUnLockData( )
	local UnLockDataLen = #UnLockData
	local numPages = math.ceil(#UnLockData / (rows * cols))
	local levelIndex = 1
	for pageIndex = 1,numPages do
		local endLevelIndex = levelIndex + (rows * cols) - 1
		if endLevelIndex > UnLockDataLen then
			endLevelIndex = UnLockDataLen
		end
		local cell = GalleryListCell.new(CCSize(display.width, rect.size.height), levelIndex, endLevelIndex, rows, cols)
		self:addCell(cell)
		levelIndex = endLevelIndex + 1
	end

	local x = (self:getClippingRect().size.width - GalleryList.INDICATOR_MARGIN * (numPages - 1)) / 2
    local y = self:getClippingRect().origin.y + 20

    self.indicator_ = display.newSprite("#selected.png")
    self.indicator_:setPosition(x, y)
    self.indicator_.firstX_ = x

    for pageIndex = 1, numPages do
        local icon = display.newSprite("#indicator.png")
        icon:setPosition(x, y)
        self:addChild(icon)
        x = x + GalleryList.INDICATOR_MARGIN
        self.indicatorList[#self.indicatorList +1] = icon
    end
    self:addChild(self.indicator_)
    if numPages > 10 then
    	self.indicator_:setVisible(false)
    	for k,v in pairs(self.indicatorList) do
    		v:setVisible(false)
    	end
    end
end

function GalleryList:scrollToCell(index, animated, time)
    GalleryList.super.scrollToCell(self, index, animated, time)
    transition.stopTarget(self.indicator_)
    local x = self.indicator_.firstX_ + (self:getCurrentIndex() - 1) * GalleryList.INDICATOR_MARGIN
    if animated then
        time = time or self.defaultAnimateTime
        transition.moveTo(self.indicator_, {x = x, time = time / 2})
    else
        self.indicator_:setPositionX(x)
    end
end

return GalleryList

