
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

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
end--]]
-- Function to handle button events


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

--[[local function handleButton1Event( event )

    --if ( "ended" == event.phase ) then
        --print( "Button was pressed and released" )
    --end
end]]--

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
        scrollHeight = 1500,
        --listener = scrollListener,
        horizontalScrollDisabled = true,
        --isBounceEnabled = false,
    }
)


sceneGroup:insert( scrollView )
	-- Code here runs when the scene is first created but has not yet appeared on screen

  local bg = display.newImage("pics/bg2.jpg")
  bg.x = display.contentCenterX
  bg.y = display.contentCenterY
  scrollView:insert(bg)

  display.setDefault( "background", 12/255, 110/255, 30/255 )

  local playButton = display.newText( scrollView, "Play", display.contentCenterX, 700, native.systemFont, 44 )
  playButton:setFillColor( 0.82, 0.86, 1 )
  --playButton:addEventListener( "tap", gotoGame )

  -- Create the widget
  local button1 = widget.newButton(
    {
      label = "button",
      labelColor = { default={ 1, 1, 1 }},
      emboss = false,
      -- Properties for a rounded rectangle button
      shape = "rect",
      width = display.contentWidth,
      height = display.contentWidth/6,
      fillColor = {default={173/255,123/255,243/255,1}},
      onPress = function(event)

      end
      --labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } }
      --fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
    }
  )

  -- Center the button
  button1.x = display.contentCenterX
  button1.y = 80
  scrollView:insert(button1)

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
