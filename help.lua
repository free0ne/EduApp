
local composer = require( "composer" )

local scene = composer.newScene()
local category = composer.getVariable( "category" )
local boldFont = "BwModelicaBold.ttf"
local thinFont = "BwModelicaThin.ttf"
local nummer = composer.getVariable( "stageNummer" )
local textHelp
local widget = require( "widget" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local helpTable =
	{
		"- В двоичной системе четные числа оканчиваются на 0, нечетные – на 1;\n- числа, которые делятся на 4, оканчиваются на 00, и т.д.; числа, которые делятся на 2k, оканчиваются на k нулей;\n- числа вида 2k записываются в двоичной системе как единица и k нулей, например: 16 = 24 = 10002;\n- числа вида 2k-1записываются в двоичной системе k единиц, например: 15 = 24-1 = 11112",
		"halp2"
	}



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

if nummer == 1 then
	textHelp = helpTable[1]
elseif nummer == 2 then
	textHelp = helpTable[2]
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local window = display.newRect( sceneGroup, display.contentCenterX,  display.contentCenterY,
  display.contentWidth, display.contentHeight )
  window:setFillColor(0.15, 0.8)
  window:addEventListener( "tap", function() composer.hideOverlay( "fade", 400 ) end)

 -- display.newRoundedRect( sceneGroup, display.contentCenterX,  490,
 -- 460, 670, 15 ):setFillColor(0.95)
end

scrollView = widget.newScrollView(
	{
		top = display.contentCenterY/5,
		left = display.contentCenterX/10,
		width = 490,
		height = display.contentCenterY/0.9,
		scrollWidth = 490,
		scrollHeight = 600, --*количество кнопок
		--listener = scrollListener,
		horizontalScrollDisabled = true,
		isBounceEnabled = false,
	}
)

local options =
{
	parent=sceneGroup,
	text = tostring (textHelp),
	x = 250,
	y = 200,
	width = 420,
	fontSize = 25,
	font = thinFont,
	align = "left"
}

	local taskHelp = display.newText(options)
	taskHelp:setFillColor(0.5, 0.5, 0.5)
	scrollView:insert(taskHelp)

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
