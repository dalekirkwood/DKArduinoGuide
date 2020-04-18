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

--set function for returning to list
local backButton

local function goBack ()
	--local prevScene = composer.getSceneName( "previous" )
	--display.remove(backButton)
	backButton:removeSelf()

	composer.gotoScene("list",sceneOptions)
end

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

----------------------------------------------------------------------------------------
--------------------------------------PUT TEXT TO SCREEN--------------------------------------------------
----------------------------------------------------------------------------------------

               
		local yPos = 350 
		local lineStart = display.actualContentWidth-50 --work out 50 from left edge
		local textStart = display.actualContentWidth -50
		local infoStart = display.actualContentWidth - 400
        
        local nameText = display.newText (sceneGroup,boardTable[tapSelection].NAME,display.contentCenterX, yPos-60, "fonts/segoeuib.ttf",66)
		nameText:setFillColor (0,0,0)
		--nameText.anchorX = 0

		local leftHandText = {"Operating Voltage", "Input Voltage", "Input Voltage Limit", "Digital Pins", "PWM Pins", "Analog Pins", "DC Current IO Pin", "DC Current 3v"}
		local rightHandText = {"Flash Memory", "SRAM", "EEPROM", "Clock Speed", "LEDs", "Length", "Width", "Weight"}
		local leftHandTextInfo = {"OPVOLTAGE","INPUTVOLTAGEREC","INPUTVOLTAGELIMIT","DIGITALPINS","PWMPINS","ANALOGPINS","DCCURRENTIOPIN","DCCURRENT3V"}
		

		for i = 1, #leftHandText do

			yPosNew = yPos + (i * 40) + 480
			print(leftHandTextInfo[i])
			local theTextLeft = display.newText (scrollView,leftHandText[i]..":",display.actualContentWidth - textStart, yPosNew, "fonts/segoeui.ttf",30)
			theTextLeft.anchorX = 0
			scrollView:insert (theTextLeft)

			local theTextRight = display.newText (scrollView,rightHandText[i]..":",display.contentCenterX+50, yPosNew, "fonts/segoeui.ttf",30)
			theTextRight.anchorX = 0
			scrollView:insert (theTextRight)

			local infoResultLeft
			local inforResultRight

			if i == 1 then
			infoResultLeft = boardTable[tapSelection].OPVOLTAGE
			inforResultRight = boardTable[tapSelection].FLASHMEM
			elseif i ==2 then
			infoResultLeft = boardTable[tapSelection].INPUTVOLTAGEREC
			inforResultRight = boardTable[tapSelection].SRAM
			elseif i ==3 then
			infoResultLeft = boardTable[tapSelection].INPUTVOLTAGELIMIT
			inforResultRight = boardTable[tapSelection].EEPROM
			elseif i ==4 then
			infoResultLeft = boardTable[tapSelection].DIGITALPINS
			inforResultRight = boardTable[tapSelection].CLOCKSPEED
			elseif i ==5 then
			infoResultLeft = boardTable[tapSelection].PWMPINS
			inforResultRight = boardTable[tapSelection].LEDS
			elseif i ==6 then
			infoResultLeft = boardTable[tapSelection].ANALOGPINS
			inforResultRight = boardTable[tapSelection].LENGTH
			elseif i ==7 then
			infoResultLeft = boardTable[tapSelection].DCCURRENTIOPIN
			inforResultRight = boardTable[tapSelection].WIDTH
			elseif i ==8 then
			infoResultLeft = boardTable[tapSelection].DCCURRENT3V
			inforResultRight = boardTable[tapSelection].WEIGHT
			end
			
			local theInfoLeft = display.newText (scrollView,infoResultLeft,display.actualContentWidth - infoStart, yPosNew, "fonts/segoeuiL.ttf",30)
			theInfoLeft.anchorX = 1
			scrollView:insert (theInfoLeft)

			local theInfoRight = display.newText (scrollView,inforResultRight,display.actualContentWidth - 50, yPosNew, "fonts/segoeuiL.ttf",30)
			theInfoRight.anchorX = 1
			scrollView:insert (theInfoRight)

		end

		local micContrText = display.newText (scrollView,"Micro Controller:",display.actualContentWidth - infoStart, yPos+480, "fonts/segoeui.ttf",30)

		local micContrTextInfo = display.newText (scrollView,boardTable[tapSelection].MICROCONTROLLER,display.actualContentWidth - 300, yPos+480, "fonts/segoeuil.ttf",30)

		micContrText.anchorX = 1
		micContrTextInfo.anchorX = 0
		
		local thumb = display.newImageRect (sceneGroup,boardTable[tapSelection].IMAGE..tapSelection..".jpg",520*1.3,330*1.3)
		thumb.x = display.contentCenterX
		thumb.y = yPos +220

		-- DESCRIPTION
		local options = {
			text = "Hello World",
			parent = sceneGroup,
			width = display.actualContentWidth - 100,
			font = "fonts/segoeui.ttf",
			fontSize = 30,
			align = "center" -- Alignment parameter
		}

		local description = display.newText(options)
		description.text = boardTable[tapSelection].DESCRIPTION
		description.anchorX = 0.5
		description.x = display.contentCenterX
		description.y = yPos + 880
		description.anchorY = 0
		description:setFillColor(0, 0, 0)
		scrollView:insert (description)

		-- DESCRIPTION END

		local line = display.newLine (sceneGroup,display.actualContentWidth - lineStart,yPos,display.actualContentWidth - 50,yPos)
		line:setStrokeColor( 112/255,112/255,112/255, 1 )
		line.strokeWidth = 6

		local line2 = display.newLine (sceneGroup,display.actualContentWidth - lineStart,yPos+860,display.actualContentWidth - 50,yPos+860)
		line2:setStrokeColor( 112/255,112/255,112/255, 1 )
		line2.strokeWidth = 6

		print ("SCROLL HEIGHT"..scrollView._view._scrollHeight)

		local whichList = ""
		-- find out where click originated
		if gMenuItemSelection == 2 then
			whichList = "entryLevel/"
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

		local function openPDF ()
			print (whichList)
			system.openURL(system.pathForFile("database/"..whichList..tapSelection..".pdf"))
			print "FUNCTION EXECUTED"
		end
if gMenuItemSelection == 2 or gMenuItemSelection == 3 or gMenuItemSelection == 4 then
		local schematics = display.newImageRect (sceneGroup,"icons/schematics.png",622,122)
		schematics.x = display.contentCenterX
		schematics.y = scrollView._view.contentHeight + 1000
	print (gMenuItemSelection)
		schematics:addEventListener ("tap", openPDF)
		scrollView:insert (schematics)
end


		scrollView:insert (nameText)
		scrollView:insert (thumb)
		

		scrollView:insert (line)
		scrollView:insert (line2)

		scrollView:insert (micContrText)
		scrollView:insert (micContrTextInfo)


		
		 
		



       -- stockRectangle[tapSelection].selection = i
        --stockRectangle[i]:addEventListener ("tap", openStockInfo)

                   

	-- Load UI and insert into Scene Group
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

	display.setDefault( "background", 244/255,244/255,244/255 )
	globalFunc.createUI()
	print (harry)
	sceneGroup:insert (gHeaderRect)
	sceneGroup:insert (gHeaderLogo)
	sceneGroup:insert (gHeaderMenu) 
	display.remove(gHeaderMenu)

	 backButton = display.newImageRect ("icons/back.png",122*0.6,122*0.6)
	backButton.x = 90 - ox
	backButton.y = 90 - oy
	
	backButton:addEventListener ("tap", goBack)

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
		composer.removeScene("detailed") --REMOVE scene so we can open another detailed view


	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	--composer.removeScene("detailed")

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
