local composer = require( "composer" )

local scene = composer.newScene()
local levelTask
local category = composer.getVariable( "category" )
local level = composer.getVariable( "level" )
local boldFont = "BwModelicaBold.ttf"
local thinFont = "BwModelicaThin.ttf"


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local levelTasks =
{
	levelText1 =
	{
		"Сколько единиц в двоичной записи указанного числа?",
		"Сколько значащих нулей в двоичной записи указанного числа?",
		"Переведите числа из 10 с/с в указанную с/с.",
		"Переведите числа из указанной с/с в десятичную с/с.",
		"Переведите числа из указанной с/с в указанную с/с.",
		"Сколько целых чисел между указанными числами?"
	},
	levelText2 =
	{
		"Определите, какой файл подходит под указанную маску.",
		"Определите, какой файл НЕ подходит под указанную маску."
	},
	levelText3 =
	{
		"Для кодирования некоторой последовательности букв решили использовать неравномерный двоичный код, позволяющий однозначно декодировать двоичную последовательность, появляющуюся на приёмной стороне канала связи. Укажите кратчайшее кодовое слово для  указанной буквы, при котором код будет допускать однозначное декодирование.",
		"Для кодирования некоторой последовательности используется неравномерный двоичный код, позволяющий однозначно декодировать полученную двоичную последовательность. Требуется сократить для одной из букв длину кодового слова так, чтобы код по-прежнему можно было декодировать однозначно. Коды остальных букв меняться не должны. Каким из указанных способов это можно сделать?"
	},
	levelText4 =
	{
		"Автомат получает на вход три цифры. Укажите, какая из следующих последовательностей символов может быть получена в результате выполения указанного алгоритма.",
		"Автомат получает на вход три шестнадцатеричных цифры, следующих в порядке невозрастания. Укажите, какая из следующих последовательностей символов может быть получена в результате выполения указанного алгоритма."
	}
}


local textLevel
	if category == 1 and level == 1 then
		textLevel = levelTasks.levelText1[1]
	elseif category == 1 and level == 2 then
		textLevel = levelTasks.levelText1[2]
	elseif category == 1 and level == 3 then
		textLevel = levelTasks.levelText1[3]
	elseif category == 1 and level == 4 then
		textLevel = levelTasks.levelText1[4]
	elseif category == 1 and level == 5 then
		textLevel = levelTasks.levelText1[5]
	elseif category == 1 and level == 6 then
		textLevel = levelTasks.levelText1[6]
	-----------------------------------------------
elseif category == 2 and level == 1 then
		textLevel = levelTasks.levelText2[1]
elseif category == 2 and level == 2 then
		textLevel = levelTasks.levelText2[2]
	-----------------------------------------------
elseif category == 3 and level == 1 then
		textLevel = levelTasks.levelText3[1]
elseif category == 3 and level == 2 then
		textLevel = levelTasks.levelText3[2]
	end



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



	local options =
	{
		parent=sceneGroup,
		text = tostring (textLevel),
		x = display.contentCenterX,
		y = display.contentCenterY,
		width = 420,
		fontSize = 45,
		font = thinFont,
		align = "center"
	}

		local taskText = display.newText(options)
		taskText:setFillColor(0.5, 0.5, 0.5)




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
