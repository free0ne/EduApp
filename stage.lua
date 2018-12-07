
local composer = require( "composer" )
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function backToCats()
  composer.gotoScene( "stageChoose" )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


-- create()
function scene:create( event )

	local sceneGroup = self.view
  display.setDefault( "background", 1, 1, 1 )
	-- Code here runs when the scene is first created but has not yet appeared on screen

  local category = composer.getVariable( "category" )
  local level = composer.getVariable( "level" )

  local derText = "Category: "..category.."; level: "..level
  local catTitle = display.newText( sceneGroup, derText, display.contentWidth/2, 100, native.systemFont, 32 )
  catTitle:setFillColor( 0, 1, 0 )
  catTitle:addEventListener( "tap", backToCats )

  ---------\\\\\\\\\\\\\\     SQL    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    local path = system.pathForFile( "tasks.db", system.DocumentsDirectory )
    local db = sqlite3.open( path )

    -- Handle the "applicationExit" event to close the database
    local function onSystemEvent( event )
        if ( event.type == "applicationExit" ) then
            db:close()
        end
    end

    local sql = "SELECT * FROM category"..category.." WHERE level = "..level.." AND tasknummer = 1"
    for row in db:nrows(sql) do
      local taskText = row.tasktext
      local task = display.newText( sceneGroup, taskText, display.contentWidth/2, 300, nil, 26 )
      task:setFillColor( 1, 0, 1 )

      local atext1 = row.answer1
      local a1 = display.newText( sceneGroup, atext1, display.contentWidth/4, 500, nil, 22 )
      a1:setFillColor( 1, 0, 1 )

      local atext2 = row.answer2
      local a2 = display.newText( sceneGroup, atext2, display.contentWidth/4*3, 500, nil, 22 )
      a2:setFillColor( 1, 0, 1 )

      local atext3 = row.answer3
      local a3 = display.newText( sceneGroup, atext3, display.contentWidth/4, 700, nil, 22 )
      a3:setFillColor( 1, 0, 1 )

      local atext4 = row.answer4
      local a4 = display.newText( sceneGroup, atext4, display.contentWidth/4*3, 700, nil, 22 )
      a4:setFillColor( 1, 0, 1 )
    end

    -- Setup the event listener to catch "applicationExit"
    Runtime:addEventListener( "system", onSystemEvent )
  ------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

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
    composer.removeScene( "stage" )
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
