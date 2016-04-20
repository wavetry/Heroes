--
-- Author: deadline
-- Date: 2016-03-08 14:45:42
--
local Levels = require("app.data.Levels")

local Segment = class("Segment",function ( nodeType,levelIndex,row,col)
	local sprite = display.newSprite()
	sprite.isWhite = nodeType == 1
	sprite.nodeType = nodeType
	sprite.levelIndex = levelIndex
	sprite.row = row
	sprite.col = col
	sprite.running = false
	GameManager.setIconTexture(sprite,nodeType,levelIndex,row,col)
	return sprite
end)



function Segment:flip( onComplete )
	if self.running then
		return 
	end
	
	self.running = true
	self:runAction(transition.sequence({
		CCScaleTo:create(0.15,0.8,0.95),
		CCScaleTo:create(0.15,0.6,0.9),
		CCScaleTo:create(0.15,0.2,0.85),
		CCScaleTo:create(0.15,0.0,0.8),
		CCCallFunc:create(function ( )
			print("self,nodeType,self.levelIndex,self.row,self.col",self.nodeType,self.levelIndex,self.row,self.col)
			if self.nodeType == Levels.NODE_IS_BLACK then
				self.nodeType = Levels.NODE_IS_WHITE
			else
				self.nodeType = Levels.NODE_IS_BLACK
			end
			GameManager.setIconTexture(self,self.nodeType,self.levelIndex,self.row,self.col)
		end),
		CCScaleTo:create(0.15,0.2,0.9),
		CCScaleTo:create(0.15,0.4,1.1),
		CCScaleTo:create(0.15,0.8,1.0),
		CCScaleTo:create(0.15,1.1,1.1),
		CCScaleTo:create(0.15,1.0,1.0),
		CCCallFunc:create(function (  )
			self.running = false
			onComplete()
		end)
		}))
	self.isWhite = not self.isWhite
end

return Segment