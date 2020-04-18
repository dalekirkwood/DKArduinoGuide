local composer = require( "composer" )
local scene = composer.newScene()
local braintonikDialog = require "plugin.braintonik-dialog"
display.setStatusBar( display.HiddenStatusBar )
local json = require ("json")

gMenuItemSelection = 0

sceneOptions = {

    effect = "fade",
    time = 800
}


local M={};

function slideMenuHandler (id)

	--local phase = event.id
	if ( id == 2 or id == 3 or id == 4 or id == 6 or id == 7 ) then gMenuItemSelection = id
		print (id)
		print (gMenuItemSelection)
		composer.removeScene("list")
        composer.gotoScene ("list",sceneOptions)
        
    elseif (id == 8 or id == 9 or id == 10 or id == 11) then
        print (id)
		print (gMenuItemSelection)
        composer.removeScene("list")
        composer.gotoScene ("comingsoon",sceneOptions)

    else print( "SM Error - No menu ID found" )
    end
 
end


function M.createUI () --function to create UI
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	print (display.actualContentHeight)
	gHeaderRect = display.newRect(400-ox, 95-oy, 800, 196 )
	gHeaderRect:setFillColor (222/255,222/255,222/255)
	gHeaderRect.anchorX =0.5
	gHeaderRect.anchorY =0.5

	gHeaderLogo = display.newImageRect ("acglogo.png",505/2,226/2)
	gHeaderLogo.x = display.contentCenterX
	gHeaderLogo.y = 100-oy

	gHeaderMenu = display.newImageRect ("icons/menu.png",122*0.6,122*0.6)
	gHeaderMenu.x = 90 - ox
	gHeaderMenu.y = 90 - oy

end

function M.openMenu()

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
                --{justify= justSetting,iconFilename="icons/wear.png", iconWidth = 50, iconHeight = 50, name="Wearables", height = listItemHeightSetting, id = 5 },
                {justify= justSetting,iconFilename="icons/retired.png", iconWidth = 50, iconHeight = 50, name="Retired", height = listItemHeightSetting, id = 6 },
                {justify= justSetting,iconFilename="icons/shields.png", iconWidth = 50, iconHeight = 50, name="Shields", height = listItemHeightSetting, id = 7 },
                {justify= justSetting,iconFilename="icons/sensors.png", iconWidth = 50, iconHeight = 50, name="Sensors", height = listItemHeightSetting, id = 8 },
                {justify= justSetting,iconFilename="icons/tutorials.png", iconWidth = 50, iconHeight = 50, name="Tutorials", height = listItemHeightSetting, id = 9 },
                {justify= justSetting,iconFilename="icons/controller.png", iconWidth = 50, iconHeight = 50, name="Controller", height = listItemHeightSetting, id = 10 },
                {justify= justSetting,iconFilename="icons/stock.png", iconWidth = 50, iconHeight = 50, name="Stock", height = listItemHeightSetting, id = 10 },


            }

            local yPosIWant = (display.actualContentHeight/2) 

			-- Set Sliding Menu Options
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
			buttonHandler = slideMenuHandler,
            itemList = itemList,}

  
    
   local mainMenu = braintonikDialog.displaySlidingDialog (menuOptions)end

 
return M;