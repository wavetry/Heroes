--
-- Author: deadline
-- Date: 2016-03-07 17:21:38
--
local Pass = class("Pass",function ( ... )
	return display.newNode()
end)

function Pass:ctor( resPath,levelIndex,batch)
	-- local icon = display.newSprite("#LockedLevelIcon.png", x, y)
	local icon = display.newSprite(resPath)
	self.icon = icon
	self.levelIndex = levelIndex
	batch:addChild(icon)

	local label = ui.newBMFontLabel({
	    text  = tostring(levelIndex),
	    font  = "UIFont.fnt",
	    x     = 0,
	    y     = - 4,
	    align = ui.TEXT_ALIGEN_CENTER,
	})
	self:addChild(label)



	if LockData[levelIndex] == 1 then
	else
		local label = ui.newTTFLabel({
		    text = "Locked",
		    font = "Marker Felt",
		    size = 20,
		    align = ui.TEXT_ALIGN_CENTER, -- 文字内部居中对齐
		    color = ccc3(255, 0, 0)
		})
		self:addChild(label)
	end
end

function Pass:isUnLocked( )
	return LockData[self.levelIndex] == 1
end

function Pass:getMyTexture()
	return self.icon
end

return Pass