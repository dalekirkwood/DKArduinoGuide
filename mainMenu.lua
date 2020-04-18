
local composer = require( "composer" )

local scene = composer.newScene()

local braintonikDialog = require "plugin.braintonik-dialog"

display.setStatusBar( display.HiddenStatusBar )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    print( display.actualContentHeight )

    display.setDefault( "background", 244/255,244/255,244/255 )

    local listItemHeightSetting = 120
    local justSetting = "Center"

        local itemList = {
                {bkNormal = {222/255,222/255,222/255}, name="",  fontSize = 36, height = 100 },
                {bkNormal = {222/255,222/255,222/255},justify= "Center",iconFilename="acglogo.png", iconWidth = 502*1.1, iconHeight = 226*1.1, name="", height = 250, id = 1 },
                {bkNormal = {222/255,222/255,222/255},justify= "Center",iconFilename="dklogo.png", iconWidth = 436*1.8, iconHeight = 58*1.8, name="", height = 80, id = 1 },
                {name="", height = 20, id = 1 },
                {justify= justSetting,iconFilename="icons/entrylevel.png", iconWidth = 50, iconHeight = 50, name="Entry Level Boards", height = listItemHeightSetting, id = 2 },
                {justify= justSetting,iconFilename="icons/enhanced.png", iconWidth = 50, iconHeight = 50, name="Enhanced Boards", height = listItemHeightSetting, id = 3 },
                {justify= justSetting,iconFilename="icons/iot.png", iconWidth = 50, iconHeight = 50, name="IoT Boards", height = listItemHeightSetting, id = 4 },
                {justify= justSetting,iconFilename="icons/wear.png", iconWidth = 50, iconHeight = 50, name="Wearables", height = listItemHeightSetting, id = 5 },
                {justify= justSetting,iconFilename="icons/retired.png", iconWidth = 50, iconHeight = 50, name="Retired", height = listItemHeightSetting, id = 6 },
                {justify= justSetting,iconFilename="icons/shields.png", iconWidth = 50, iconHeight = 50, name="Shields", height = listItemHeightSetting, id = 7 },
                {justify= justSetting,iconFilename="icons/sensors.png", iconWidth = 50, iconHeight = 50, name="Sensors", height = listItemHeightSetting, id = 8 },
                {justify= justSetting,iconFilename="icons/tutorials.png", iconWidth = 50, iconHeight = 50, name="Tutorials", height = listItemHeightSetting, id = 9 },
                {justify= justSetting,iconFilename="icons/controller.png", iconWidth = 50, iconHeight = 50, name="Controller", height = listItemHeightSetting, id = 10 },
            }

            local yPosIWant = (display.actualContentHeight/2) 

        local menuOptions = { 
            --wDialog = 600,
            --wScreen =300,
            itemListFontSize = 30, 
            hScreen = display.actualContentHeight,
            wDialog = display.actualContentWidth*0.66,
            yScreen = display.contentCenterY-yPosIWant,
            itemListIconMarginPadding = 50,
            itemListTextMarginPadding = 140,
            bkColor = {244/255,244/255,244/255,1},
            itemListFont = "fonts/segoeui.ttf",
            borderSize = 2,
            borderColor = {222/255,222/255,222/255},
            itemListTextColor = {0,0,0}, 
            itemListTextSelectedColor = {0/255,135/255,143/255},
            appearsFrom = "left",
            itemList = itemList,}

  
    
   local mainMenu = braintonikDialog.displaySlidingDialog (menuOptions)
    
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
