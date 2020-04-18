
local composer = require( "composer" )

local scene = composer.newScene()

local braintonikDialog = require "plugin.braintonik-dialog"

display.setStatusBar( display.HiddenStatusBar )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function clearsplash ()
	composer.gotoScene( "home",sceneOptions )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    print( display.actualContentHeight )

	display.setDefault( "background", 244/255,244/255,244/255 )

	local logo = display.newImageRect (sceneGroup, "acglogo.png",251*2.5,113*2.5)
	logo.x = display.contentCenterX
	logo.y = display.contentCenterY-100

	local dklogo = display.newImageRect (sceneGroup, "dklogo.png",219*2,29*2)
	dklogo.x = display.contentCenterX
	dklogo.y = display.contentCenterY + 250

	timer.performWithDelay( 2500, clearsplash )

    
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
