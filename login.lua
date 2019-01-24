
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local usernameField
local passwordField
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function networkListener( event )

    if ( event.isError ) then
        print( "Network error: ", event.response )
    else
        print ( "RESPONSE: " .. event.response )
    end
end

local function sendValues()
  local headers = {}

  headers["Content-Type"] = "application/x-www-form-urlencoded"
  headers["Accept-Language"] = "en-US"

  --local body = "id=1&size=small"
  local body = "username="..usernameField.text.."&password="..passwordField.text

  local params = {}
  params.headers = headers
  params.body = body

  network.request( "http://eduapp.pp/register.php", "POST", networkListener, params )
end



local function textListener( event )

    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        --print( event.target.text )

    elseif ( event.phase == "editing" ) then
        --print( event.newCharacters )
        --print( event.oldText )
        --print( event.startPosition )
        --print( event.text )
    end
end

local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        print( usernameField.text )
				print( passwordField.text )
				sendValues()
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local window = display.newRect( sceneGroup, display.contentCenterX,  display.contentCenterY,
  display.contentWidth, display.contentHeight )
  window:setFillColor(0.15, 0.8)

  display.newRoundedRect( sceneGroup, display.contentCenterX,  490,
  460, 670, 15 ):setFillColor(0.95)

	usernameField = native.newTextField( display.contentCenterX, 350, display.contentWidth*0.6, 60 )
	usernameField:addEventListener( "userInput", textListener )
	sceneGroup:insert(usernameField)

	passwordField = native.newTextField( display.contentCenterX, 480, display.contentWidth*0.6, 60 )
	passwordField:addEventListener( "userInput", textListener )
	sceneGroup:insert(passwordField)

	local send = widget.newButton(
    {
        label = "SEND",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 200,
        height = 40,
        cornerRadius = 2,
        fillColor = { default={1,1,0,1}, over={1,0.1,0.7,0.4} },
    }
)

-- Center the button
send.x = display.contentCenterX
send.y = 600
sceneGroup:insert(send)

	local exit = widget.newButton(
    {
      shape = "circle",
      radius = 40,
      label = "?",
      font = "displayOTF.ttf",
      fontSize = 45,
      fillColor = { default={ 1, 0, 0, 0.4 }, over={ 1, 0, 0, 0.4 } },
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      onPress = function() composer.hideOverlay( "fade", 400 ) end
    }
  )
  exit.x = 100
  exit.y = 210
  exit:scale(1, 1)
  sceneGroup:insert(exit)
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
