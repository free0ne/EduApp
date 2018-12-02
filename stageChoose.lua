
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
  local category = 0
  local categoryName = "Название категории"

  local function backToMenu()
    composer.gotoScene( "menu" )
  end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  category = composer.getVariable( "stageNummer" )
  if category == 1 then
    categoryName = "Системы счисления"
  elseif category == 2 then
    categoryName = "Тема 2"
  elseif category == 3 then
    categoryName = "Тема 3"
  elseif category == 4 then
    categoryName = "Тема 4"
  elseif category == 5 then
    categoryName = "Тема 5"
  elseif category == 6 then
    categoryName = "Тема 6"
  elseif category == 7 then
    categoryName = "Тема 7"
  end

  -- не забывай добавлять в группы! (sceneGroup)
  local catTitle = display.newText( sceneGroup, categoryName, display.contentWidth/2, 100, native.systemFont, 32 )
  catTitle:setFillColor( 0, 1, 0 )
  catTitle:addEventListener( "tap", backToMenu )


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

    --ОБРАТИ ВНИМАНИЕ, ТУТ СЦЕНУ ЧИСТИМ, иначе при возвращении в меню
    --она сохранится, и не важно что потом уже выберешь
    composer.removeScene( "stageChoose" )
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
