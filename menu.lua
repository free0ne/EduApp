local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local buttonsFont = "calibri"
local buttonsFontSize = 30

-- ScrollView listener
--[[local function scrollListener( event )

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
end]]--
-- Function to handle button events


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
  local sceneGroup = self.view

    -- Create the widget
  local scrollView = widget.newScrollView(
      {
          top = 0,
          left = 0,
          width = display.contentWidth,
          height = display.contentHeight,
          scrollWidth = 540,
          scrollHeight = 160*7, --*количество кнопок
          --listener = scrollListener,
          horizontalScrollDisabled = true,
          isBounceEnabled = false,
      }
  )

  local function handleButtonEvent( event )

    local phase = event.phase
    if ( "ended" == phase ) then

        nummer = event.target.nummer
        print( "Button #"..nummer.." was pressed and released" )
        --!!передача данных в другую сцену
        composer.setVariable( "stageNummer", nummer )
        composer.gotoScene( "stageChoose" )
    end

    if ( phase == "moved" ) then
        local dy = math.abs( ( event.y - event.yStart ) )
        -- If the touch on the button has moved more than 10 pixels,
        -- pass focus back to the scroll view so it can continue scrolling
        if ( dy > 10 ) then
            scrollView:takeFocus( event )
        end
    end
    return true
  end

	-- Code here runs when the scene is first created but has not yet appeared on screen

  -- Create the widget

  -- create buttons array
  local buttons = {}
  for i = 0, 6 do
    buttons[i] = widget.newButton(
      {
        labelXOffset = 20,
        label = "categoryName",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        labelAlign = "left",
        font = buttonsFont,
        fontSize = buttonsFontSize,
        shape = "rect",
        width = display.contentWidth,
        height = display.contentHeight/6,
        --fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
        onEvent = handleButtonEvent
      }
    )
      if i == 0 then
        buttons[i]:setLabel("системы\nсчисления")
        buttons[i]:setFillColor( 173/255,123/255,243/255 )
        buttons[i].x = display.contentCenterX
        buttons[i].y = 80
        buttons[i].nummer = 1
      elseif i == 1 then
        buttons[i]:setLabel("Тема 2")
        buttons[i]:setFillColor( 187/255,136/255,219/255 )
        buttons[i].x = display.contentCenterX
        buttons[i].y = 240
        buttons[i].nummer = 2
      elseif i == 2 then
        buttons[i]:setLabel("Тема\nномер 3")
        buttons[i]:setFillColor( 202/255,150/255,194/255 )
        buttons[i].x = display.contentCenterX
        buttons[i].y = 400
        buttons[i].nummer = 3
      elseif i == 3 then
        buttons[i]:setLabel("Тема\nномер 4")
        buttons[i]:setFillColor( 212/255,159/255,175/255 )
        buttons[i].x = display.contentCenterX
        buttons[i].y = 560
        buttons[i].nummer = 4
      elseif i == 4 then
        buttons[i]:setLabel("Тема 5")
        buttons[i]:setFillColor( 224/255,170/255,155/255 )
        buttons[i].x = display.contentCenterX
        buttons[i].y = 720
        buttons[i].nummer = 5
      elseif i == 5 then
        buttons[i]:setLabel("Тема\nномер 6")
        buttons[i]:setFillColor( 237/255,182/255,133/255 )
        buttons[i].x = display.contentCenterX
        buttons[i].y = 880
        buttons[i].nummer = 6
      elseif i == 6 then
        buttons[i]:setLabel("Тема 7")
        buttons[i]:setFillColor( 249/255,198/255,133/255 )
        buttons[i].x = display.contentCenterX
        buttons[i].y = 1040
        buttons[i].nummer = 7
      end
      scrollView:insert(buttons[i])
  end


  -- начало отдельной кнопки
  --[[local button1 = widget.newButton(
    {
      labelXOffset = 20,
      label = "системы\nсчисления",
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      labelAlign = "left",
      font = buttonsFont,
      fontSize = buttonsFontSize,
      shape = "rect",
      width = display.contentWidth,
      height = display.contentHeight/6,
      fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
      onEvent = handleButtonEvent
    }
  )
  --button1:addEventListener ( handleButtonEvent, "1" )
  button1.x = display.contentCenterX
  button1.y = 80
  button1.nummer = 1
  scrollView:insert(button1)

  -- конец отдельной кнопки
  --]]

  sceneGroup:insert( scrollView )
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
