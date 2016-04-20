--
-- Author: deadline
-- Date: 2016-03-07 15:00:55
--

SEGMENTSIZE = 80

GameManager = {}

GameManager.currentIndex = 1
GameManager.currentPass = 1 	--当前关卡

function GameManager.saveTable( file,obj )
	local szType = type(obj)
	if szType == "table" then
		file:write('{\n')
		for i,v in pairs(obj) do
			file:write("[")
			GameManager.saveTable(file,i)
			file:write("]=\n")
		end
		file:write("}\n")
	else
		file:write(obj)
	end
end

function GameManager.saveGameData( key,value)
	if LockData[key] == value then
		return 
	end
	LockData[key] = value
	local basepath = CCFileUtils:sharedFileUtils():getWritablePath()
	local pathForFileName = basepath .."LockData.lua"
	if CCFileUtils:sharedFileUtils():isFileExist(pathForFileName) then
		print ("LockData is exist")
	end
	local file = io.open(pathForFileName,'a+')
	local addStr = string.format("LockData[%d] = %d\n",key,value)
	file:write(addStr)
	file:flush()
	file:close()
end

function GameManager.setIconTexture( sprite,nodeType,levelIndex,row,col)
	local resPath
	local TextureSprite
	local cache 
	local cacheSize

	if nodeType == 0 then
		resPath = "dota/logo.png"
		TextureSprite = display.newSprite(resPath)
		cache = TextureSprite:getTexture()
		cacheSize = cache:getContentSize()
		sprite:setTexture(cache)
		sprite:setTextureRect(CCRect(0, 0, SEGMENTSIZE,SEGMENTSIZE))
	else
		resPath = string.format("dota/%d.jpg",levelIndex)
		TextureSprite = display.newSprite(resPath)
		cache = TextureSprite:getTexture()
		cacheSize = cache:getContentSize()
		sprite:setTexture(cache)
		local x = (col - 1) * SEGMENTSIZE + (cacheSize.width - CONFIG_SCREEN_WIDTH)/2
		local y = (row - 1) * SEGMENTSIZE
		sprite:setTextureRect(CCRect(x, y, SEGMENTSIZE,SEGMENTSIZE))
	end
end

function GameManager.getUnLockData( )
	local UnLockData = {}
	for k,v in pairs(LockData) do
		if v == 1 then
			table.insert(UnLockData,k)
		end
	end
	dump(UnLockData)
	table.sort(UnLockData)
	return UnLockData
end

function GameManager.autoScale( node)
	
	local scaleW = display.width/node:getContentSize().width
	local scaleH = display.height/node:getContentSize().height

	local scale = math.max(scaleW,scaleH)
	node:setScale(scale)
end

function GameManager.playBgMusic( filename )
	audio.stopMusic(true)
	audio.preloadMusic(filename)
	audio.playMusic(filename,true)
	-- body
end

function GameManager.showSpotView( )	--调用java方法展示插屏广告
	do return end
	local javaClassName = "com.lzl.games.heros.Heros"
	local javaMethodName = "showSpot"
	local javaParams = {
                "How are you ?",
                "I'm great !",
                function(event)
                    printf("Java method callback value is [%s]", event)
                end
            }
	local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;I)V"
	print("===showSpotView===")
	luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
end
