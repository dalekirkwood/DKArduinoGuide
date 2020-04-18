local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local braintonikDialog = require "plugin.braintonik-dialog"
display.setStatusBar( display.HiddenStatusBar )
local json = require ("json")


-- decalre variable
local whichList = ""
-- find out where click originated
if gMenuItemSelection == 2 then
	whichList = "entryLevel.json"
elseif gMenuItemSelection == 3 then
	whichList = "enhanced.json"
elseif gMenuItemSelection == 4 then
	whichList = "iot.json"
elseif gMenuItemSelection == 5 then
	whichList = "wear.json"
elseif gMenuItemSelection == 6 then
	whichList = "retired.json"
elseif gMenuItemSelection == 7 then
	whichList = "shields.json"
elseif gMenuItemSelection == 8 then
	whichList = "sensors.json"
end

--open file
local filePath = system.pathForFile ("database/"..whichList)
local file = io.open (filePath, "r") --open file as read only
local contents = file:read("*a") -- load contents into variable 'contents'
io.close(file) -- closes the file
local boardTable = json.decode (contents) -- decode the file into LUA table

-- for setting up eventlisteners to open info
local selectRect = {}

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local globalFunc = require("globalFunc")

display.setDefault("fillColor", 0,0,0,1)

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

	-- Test reading JSON ok
    print (boardTable[1].NAME)
    print (boardTable[1].MICROCONTROLLER)
	print (#boardTable)



	---------------------------------------------------------------------------------------------------------------
	---------------------------------------CREATE SCROLL VIEW------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------
		-- ScrollView listener
local function scrollListener( event )
 
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
	end
 
    -- In the event a scroll limit is reached...
	if ( event.limitReached ) then
		if ( event.direction == "up" ) then print( "Reached bottom limit" )
		elseif ( event.direction == "down" ) then print( "Reached top limit" )
		elseif ( event.direction == "left" ) then print( "Reached right limit" )
		elseif ( event.direction == "right" ) then print( "Reached left limit" )
	end
end
 
return true
end

-- Create the widget
scrollView = widget.newScrollView(
    {
      -- top = 0,
		--left = 0,
		x = display.contentCenterX,
		y = display.contentCenterY,
		height = display.actualContentHeight,
		width = display.actualContentWidth,
        --scrollWidth = 600,
		listener = scrollListener,
		horizontalScrollDisabled = true,
		backgroundColor = { 244/255,244/255,244/255 }
    }
)

sceneGroup:insert (scrollView)

-------------------------------------END----------------------------------------------------

	-- Function for list tap
	local function listTap (event)
		print ("Tap works")
		tapSelection = event.target.selection
		composer.gotoScene ("detailed",sceneOptions)
	end

	--build list
	for i = 1, #boardTable  do
		
		               
        local yPos = 50 + (i * 300)    
		
		selectRect[i] = display.newRect(sceneGroup,display.contentCenterX, yPos-110, display.actualContentWidth, 250 )
		selectRect[i]:setFillColor( 244/255,244/255,244/255,1)
		selectRect[i].anchorY = 0
	

		scrollView:insert (selectRect[i])
		selectRect[i].selection = i
        selectRect[i]:addEventListener ("tap", listTap)

        local nameText = display.newText (sceneGroup,boardTable[i].NAME,display.contentCenterX-80, yPos-90, "fonts/segoeuib.ttf",36)
		nameText:setFillColor (0,0,0)
		nameText.anchorX = 0

		local digPinText = display.newText (scrollView,"Digital Pins:",display.contentCenterX-80, yPos-40, "fonts/segoeui.ttf",30)
		local pwmPinText = display.newText (scrollView,"PWM Pins:",display.contentCenterX-80, yPos+10, "fonts/segoeui.ttf",30)
		local analogPinText = display.newText (scrollView,"Analog Pins:",display.contentCenterX-80, yPos+60, "fonts/segoeui.ttf",30)
		local flashMemText = display.newText (scrollView,"Flash Memory:",display.contentCenterX-80, yPos+110, "fonts/segoeui.ttf",30)

		local digPinTextInfo = display.newText (scrollView,boardTable[i].DIGITALPINS,display.actualContentWidth-80, yPos-40, "fonts/segoeuil.ttf",30)
		local pwmPinTextInfo = display.newText (scrollView,boardTable[i].PWMPINS,display.actualContentWidth-80, yPos+10, "fonts/segoeuil.ttf",30)
		local analogPinTextInfo = display.newText (scrollView,boardTable[i].ANALOGPINS,display.actualContentWidth-80, yPos+60, "fonts/segoeuil.ttf",30)
		local flashMemTextInfo = display.newText (scrollView,boardTable[i].FLASHMEM,display.actualContentWidth-80, yPos+110, "fonts/segoeuil.ttf",30)

		digPinText.anchorX = 0
		pwmPinText.anchorX = 0
		analogPinText.anchorX = 0
		flashMemText.anchorX = 0
		digPinTextInfo.anchorX = 1
		pwmPinTextInfo.anchorX = 1
		analogPinTextInfo.anchorX = 1
		flashMemTextInfo.anchorX = 1

		
		local thumb = display.newImageRect (sceneGroup,boardTable[i].IMAGE..i..".jpg",520/2,330/2)
		thumb.x = display.actualContentWidth * 0.2
		thumb.y = yPos

		local lineStart = display.actualContentWidth-50 --work out 50 from left edge

		local line = display.newLine (sceneGroup,display.actualContentWidth - lineStart,yPos+160,display.actualContentWidth - 50,yPos+160)
		line:setStrokeColor( 222/255,222/255,222/255, 1 )
		line.strokeWidth = 4

		scrollView:insert (digPinText)
		scrollView:insert (pwmPinText)
		scrollView:insert (analogPinText)
		scrollView:insert (flashMemText)
		scrollView:insert (digPinTextInfo)
		scrollView:insert (pwmPinTextInfo)
		scrollView:insert (analogPinTextInfo)
		scrollView:insert (flashMemTextInfo)
		scrollView:insert (nameText)
		scrollView:insert (thumb)
		scrollView:insert (line)



		
		 
		



       -- stockRectangle[i].selection = i
        --stockRectangle[i]:addEventListener ("tap", openStockInfo)

        i = i + 1
                   
end
	-- Load UI and insert into Scene Group
	display.setDefault( "background", 244/255,244/255,244/255 )
	globalFunc.createUI()
	print (harry)
	sceneGroup:insert (gHeaderRect)
	sceneGroup:insert (gHeaderLogo)
	sceneGroup:insert (gHeaderMenu)
	gHeaderMenu:addEventListener ("tap", globalFunc.openMenu)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
