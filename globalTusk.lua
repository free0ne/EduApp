local composer = require( "composer" )

local scene = composer.newScene()
local name
local category = composer.getVariable( "category" )
local level = composer.getVariable( "level" )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------



-- create()
function scene:create( event )

--	local sceneGroup = self.view

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local window = display.newRect( sceneGroup, display.contentCenterX,  display.contentCenterY,
  display.contentWidth, display.contentHeight )
  window:setFillColor(0.15, 0.8)




  window:addEventListener( "tap", function() composer.hideOverlay( 400 ) end)

  display.newRoundedRect( sceneGroup, display.contentCenterX,  490,
  460, 670, 15 ):setFillColor(0.95)

	local nameTable2 =
	{
		open = {"task", "task2"},
		high = 154,
		low = 140,
		close = 150
	}

	if category == 1 and level == 1 then


		print(nameTable2.open[2])

		local options =
		{
			parent=sceneGroup,
			text = nameTable2.open[2]--[[В какой минимальной с/с можно записать указанное число?]],
			x = display.contentCenterX,
			y = display.contentCenterY,
			width = 420,
			fontSize = 45,
			font = "displayOTF",
			align="center"
		}
		local taskText = display.newText(options)
		taskText:setFillColor(0.6,0.5,0.9)

	elseif category == 1 and level == 2 then
		local options =
		{
			parent=sceneGroup,
			text = [[Какое число следущее в указанной с/с?]],
			x = display.contentCenterX,
			y = display.contentCenterY,
			width = 420,
			fontSize = 45,
			font = "displayOTF",
			align="center"
		}
		local taskText = display.newText(options)
		taskText:setFillColor(0.6,0.5,0.9)

	elseif category == 1 and level == 3 then
		local options =
		{
			parent=sceneGroup,
			text = [[Перевод числа из 10 с/с в указанную с/с]],
			x = display.contentCenterX,
			y = display.contentCenterY,
			width = 420,
			fontSize = 45,
			font = "displayOTF",
			align="center"
		}
		local taskText = display.newText(options)
		taskText:setFillColor(0.6,0.5,0.9)

	elseif category == 1 and level == 4 then
		local options =
		{
			parent=sceneGroup,
			text = [[Перевод числа из 10 с/с в указанную с/с]],
			x = display.contentCenterX,
			y = display.contentCenterY,
			width = 420,
			fontSize = 45,
			font = "displayOTF",
			align="center"
		}
		local taskText = display.newText(options)
		taskText:setFillColor(0.6,0.5,0.9)
		name = display.newText(sceneGroup, "Перевод числа\nиз указанной с/с\nв десятичную с/с", display.contentCenterX, display.contentCenterY, "displayOTF.ttf", 45)
		name:setFillColor(1,0,0)
		name.align = "center"
	elseif category == 1 and level == 5 then
		local options =
		{
			parent=sceneGroup,
			text = [[Перевод числа из 10 с/с в указанную с/с]],
			x = display.contentCenterX,
			y = display.contentCenterY,
			width = 420,
			fontSize = 45,
			font = "displayOTF",
			align="center"
		}
		local taskText = display.newText(options)
		taskText:setFillColor(0.6,0.5,0.9)
		name = display.newText(sceneGroup, "Перевод числа\nиз указанной с/с\nв указанную с/с", display.contentCenterX, display.contentCenterY, "displayOTF.ttf", 45)
		name:setFillColor(1,0,0)
		name.align = "center"
	elseif category == 1 and level == 6 then
		local options =
		{
			parent=sceneGroup,
			text = [[Перевод числа из 10 с/с в указанную с/с]],
			x = display.contentCenterX,
			y = display.contentCenterY,
			width = 420,
			fontSize = 45,
			font = "displayOTF",
			align="center"
		}
		local taskText = display.newText(options)
		taskText:setFillColor(0.6,0.5,0.9)
		name = display.newText(sceneGroup, "Сколько целых\nчисел между двумя\nуказанными числами?", display.contentCenterX, display.contentCenterY, "displayOTF.ttf", 45)
		name:setFillColor(1,0,0)
		name.align = "center"
	end


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
    composer.removeScene( "help" )
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
