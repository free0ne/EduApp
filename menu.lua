local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local buttonsFont = "calibri"
local buttonsFontSize = 30


local function gotoCat1()
    composer.gotoScene( "cat1" )
end

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

  local function handleButton1Event( event )

    local phase = event.phase
    if ( "ended" == phase ) then
        print( "Button was pressed and released" )
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

  local bg = display.newImage("pics/bg2.jpg")
  bg.x = display.contentCenterX
  bg.y = display.contentCenterY
  scrollView:insert(bg)

  display.setDefault( "background", 12/255, 110/255, 30/255 )

  -- Create the widget

  -- начало отдельной кнопки
  local button1 = widget.newButton(
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
      onEvent = handleButton1Event
    }
  )
  button1.x = display.contentCenterX
  button1.y = 80
  scrollView:insert(button1)
  -- конец отдельной кнопки
  -- начало отдельной кнопки
  local button2 = widget.newButton(
    {
      labelXOffset = 20,
      label = "Тема 2",
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      labelAlign = "left",
      font = buttonsFont,
      fontSize = buttonsFontSize,
      shape = "rect",
      width = display.contentWidth,
      height = display.contentHeight/6,
      fillColor = { default={187/255,136/255,219/255,1}, over={187/255,136/255,219/255,1} },
      onEvent = handleButton1Event
    }
  )
  button2.x = display.contentCenterX
  button2.y = 240
  scrollView:insert(button2)
  -- конец отдельной кнопки
  -- начало отдельной кнопки
  local button3 = widget.newButton(
    {
      labelXOffset = 20,
      label = "Тема\nномер 3",
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      labelAlign = "left",
      font = buttonsFont,
      fontSize = buttonsFontSize,
      shape = "rect",
      width = display.contentWidth,
      height = display.contentHeight/6,
      fillColor = { default={202/255,150/255,194/255,1}, over={202/255,150/255,194/255,1} },
      onEvent = handleButton1Event
    }
  )
  button3.x = display.contentCenterX
  button3.y = 400
  scrollView:insert(button3)
  -- конец отдельной кнопки
  -- начало отдельной кнопки
  local button4 = widget.newButton(
    {
      labelXOffset = 20,
      label = "Тема\nномер 4",
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      labelAlign = "left",
      font = buttonsFont,
      fontSize = buttonsFontSize,
      shape = "rect",
      width = display.contentWidth,
      height = display.contentHeight/6,
      fillColor = { default={212/255,159/255,175/255,1}, over={212/255,159/255,175/255,1} },
      onEvent = handleButton1Event
    }
  )
  button4.x = display.contentCenterX
  button4.y = 560
  scrollView:insert(button4)
  -- конец отдельной кнопки
  -- начало отдельной кнопки
  local button5 = widget.newButton(
    {
      labelXOffset = 20,
      label = "Тема\nномер 5",
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      labelAlign = "left",
      font = buttonsFont,
      fontSize = buttonsFontSize,
      shape = "rect",
      width = display.contentWidth,
      height = display.contentHeight/6,
      fillColor = { default={224/255,170/255,155/255,1}, over={224/255,170/255,155/255,1} },
      onEvent = handleButton1Event
    }
  )
  button5.x = display.contentCenterX
  button5.y = 720
  scrollView:insert(button5)
  -- конец отдельной кнопки
  -- начало отдельной кнопки
  local button6 = widget.newButton(
    {
      labelXOffset = 20,
      label = "Тема\nномер 6",
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      labelAlign = "left",
      font = buttonsFont,
      fontSize = buttonsFontSize,
      shape = "rect",
      width = display.contentWidth,
      height = display.contentHeight/6,
      fillColor = { default={237/255,182/255,133/255,1}, over={237/255,182/255,133/255,1} },
      onEvent = handleButton1Event
    }
  )
  button6.x = display.contentCenterX
  button6.y = 880
  scrollView:insert(button6)
  -- конец отдельной кнопки
  -- начало отдельной кнопки
  local button7 = widget.newButton(
    {
      labelXOffset = 20,
      label = "Тема\nномер 7",
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      labelAlign = "left",
      font = buttonsFont,
      fontSize = buttonsFontSize,
      shape = "rect",
      width = display.contentWidth,
      height = display.contentHeight/6,
      fillColor = { default={249/255,198/255,133/255,1}, over={249/255,198/255,133/255,1} },
      onEvent = handleButton1Event
    }
  )
  button7.x = display.contentCenterX
  button7.y = 1040
  scrollView:insert(button7)
  -- конец отдельной кнопки

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
