--
-- Author: deadline
-- Date: 2016-03-09 16:36:55
--
SCALECONST = 0.4
local GalleryMap = class("GalleryMap",function ( levelIndex ,x,y)
	local path = string.format("dota/%d.jpg",levelIndex)
	local icon = display.newSprite(path,x,y)
	icon:setScale(SCALECONST)
	icon.running = false
	icon.isBig = false
	icon.x = x
	icon.y = y
	return icon
end)

function GalleryMap:ctor()
	self:setTouchSwallowEnabled(false)
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		if event.name == "began" then
			return true
		end
		if event.name == "ended" then
			self:animate()
			audio.playSound(GAME_SFX.tapButton)
		end
		end)
end

function GalleryMap:animate(  )
	local function zoom1(offset, time, onComplete)
	    local x, y = self:getPosition()
	    local size = self:getContentSize()

	    local scaleX = self:getScaleX() * (size.width + offset) / size.width
	    local scaleY = self:getScaleY() * (size.height - offset) / size.height
	   
	    transition.moveTo(self, {y = y - offset, time = time})
	    transition.scaleTo(self, {
	        scaleX     = scaleX,
	        scaleY     = scaleY,
	        time       = time,
	        onComplete = onComplete,
	    })
	end

	local function zoom2(offset, time, onComplete)
	    local x, y = self:getPosition()
	    local size = self:getContentSize()

	    transition.moveTo(self, {y = y + offset, time = time / 2})
	    transition.scaleTo(self, {
	        scaleX     = 1.0*SCALECONST,
	        scaleY     = 1.0*SCALECONST,
	        time       = time,
	        onComplete = onComplete,
	    })
	end
	zoom1(40, 0.08, function()
	    zoom2(40, 0.09, function()
	        zoom1(20, 0.10, function()
	            zoom2(20, 0.11, function()
	            end)
	        end)
	    end)
	end)
end

return GalleryMap