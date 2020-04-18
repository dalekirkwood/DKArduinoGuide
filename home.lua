local composer = require( "composer" )
local scene = composer.newScene()
local braintonikDialog = require "plugin.braintonik-dialog"
display.setStatusBar( display.HiddenStatusBar )
local globalFunc = require("globalFunc")
local widget = require( "widget" )




-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function emailMe ()
system.openURL ("mailto:dalekirkwood@gmail.com")
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	
	local fromTop = display.actualContentHeight - 200

	print( display.actualContentHeight )
	
	display.setDefault( "background", 244/255,244/255,244/255 )
	globalFunc.createUI()
	print (harry)
	sceneGroup:insert (gHeaderRect)
	sceneGroup:insert (gHeaderLogo)
	sceneGroup:insert (gHeaderMenu)
	gHeaderMenu:addEventListener ("tap", globalFunc.openMenu)

    display.setDefault( "background", 244/255,244/255,244/255 )

	local logo = display.newImageRect (sceneGroup, "acglogo.png",251*2.5,113*2.5)
	logo.x = display.contentCenterX
	logo.y = display.actualContentHeight-fromTop

	-- DESCRIPTION
	local options = {
		text = "Hello World",
		parent = sceneGroup,
		width = display.actualContentWidth - 100,
		font = "fonts/segoeui.ttf",
		fontSize = 40,
		align = "center" -- Alignment parameter
	}

	local description = display.newText(options)
	description.text = "Hi and thanks for downloading the BETA version of this App. If you find bugs, please help by reporting them to me dalekirkwood@gmail.com. I also need help to finish building this into a great app so please, if you have some time to spare, feel free to volunteer."
	description.anchorX = 0.5
	description.x = display.contentCenterX
	description.y = display.actualContentHeight-(fromTop - 200)
	description.anchorY = 0
	description:setFillColor(0, 0, 0)
	--scrollView:insert (description)

	-- DESCRIPTION END

	local function handleButtonEvent( event )
 
		if ( "ended" == event.phase ) then
			print( "Button was pressed and released" )
			emailMe ()
		end
	end

	local buttonOptions = {

		x = display.contentCenterX,
		y = display.actualContentHeight-(fromTop - 800),
		onEvent = handleButtonEvent,
		label = "Email Me",
		labelColor = { default={ 1,1,1 }, over={ 0, 0, 0, 0.5 } },
		fillColor = { default={ 0/255,135/255,143/255 }, over={ 0/255,135/255,143/255,0.5 } },
		fontSize = 46,
		shape = "roundedRect",
		width = 500,
		height = 140

	}

	local emailMeButon = widget.newButton( buttonOptions )
	sceneGroup:insert (emailMeButon)
    
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
