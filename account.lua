local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()
local boldFont = "BwModelicaBold.ttf"

local json = require( "json" )
local accountTable = {}
local filePath = system.pathForFile( "account.json", system.DocumentsDirectory )

local isLoggedIn = false
local regGroup
local regButton
local loginButton
local userLabel
local userField
local passLabel
local passField
local sendRegButton
local sendLoginButton
local result

local buttonsFont = "BwModelicaBold.ttf"

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function backToMenu()
  composer.gotoScene( "menu" )
end

local function loadAcc()

    local file = io.open( filePath, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
        accountTable = json.decode( contents )
    end

    if ( accountTable == nil or #accountTable == 0 ) then
        accountTable = {0, 0}
        isLoggedIn = false

        file = io.open( filePath, "w" )

        if file then
            file:write( json.encode( accountTable ) )
            io.close( file )
        end

        print("first try")
    elseif accountTable[1] == 0 then
        print ("not logged in")
        isLoggedIn = false
    else
        print (accountTable[1].."   "..accountTable[2])
    end
end


local function textListener( event )

    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        --print( event.target.text )

    elseif ( event.phase == "editing" ) then
        --[[print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )]]--
    end
end

local function networkListener( event )
    if ( event.isError ) then
        print( "Network error: ", event.response )
    else
        print ( "RESPONSE: #" .. event.response.."#" )
        response = event.response
        response = response:gsub("%s+", "")
        if (response == "0") then
            result.text = "Регистрация прошла успешно,\nможно войти в аккаунт"
        elseif response == "1" then
            result.text = "Длина логина должна \nсоставлять от 6 до 16\nсимволов"
        elseif response == "2" then
            result.text = "Длина пароля должна \nсоставлять от 6 до 16\nсимволов"
        elseif response == "3" then
            result.text = "Логин занят"
        elseif response == "4" then
            result.text = "Неверный логин или пароль"
        elseif response == "5" then
            result.text = "Вы вошли в систему"
        elseif #response == 32 then
            result.text = response
        end
    end
--for i in string.gmatch(response, "%S+") do
--     results[pos] = i
--     pos = pos + 1
--end
--pos = 0
--for i = 0, 2 do
--    buttons[i]:setLabel(" "..tostring(i+1).."\n"..results[i].."/9")
--end
end

local function handleButtonEvent( event )
    local phase = event.phase
    if ( "ended" == phase ) then
        nummer = event.target.nummer
        --!!передача данных в другую сцену
        if nummer == "chooseReg" then
            sendLoginButton.isVisible = false
            sendRegButton.isVisible = true
            result.text = ""
        elseif nummer == "chooseLogin" then
            sendRegButton.isVisible = false
            sendLoginButton.isVisible = true
            result.text = ""
        elseif nummer == "sendReg" then
            local headers = {}
            headers["Content-Type"] = "application/x-www-form-urlencoded"
            headers["Accept-Language"] = "en-US"
            --local body = "id=1&size=small"
            local body = "username="..userField.text.."&password="..passField.text

            local params = {}
            params.headers = headers
            params.body = body

            network.request( "http://eduapp.pp/register.php", "POST", networkListener, params )
        elseif nummer == "sendLogin" then
            local headers = {}
            headers["Content-Type"] = "application/x-www-form-urlencoded"
            headers["Accept-Language"] = "en-US"
            --local body = "id=1&size=small"
            local body = "username="..userField.text.."&password="..passField.text

            local params = {}
            params.headers = headers
            params.body = body

            network.request( "http://eduapp.pp/login.php", "POST", networkListener, params )
        end
    end
    return true

end
-- create()
function scene:create( event )

    local sceneGroup = self.view

    regGroup = display.newGroup()
    -- Code here runs when the scene is first created but has not yet appeared on screen
    display.setDefault( "background", 1, 1, 1 )
    local catTitle = widget.newButton(
      {
        shape = "rect",
        width = 100,
        height = 100,
        label = "<",
        fontSize = 60,
        font = boldFont,
        fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        labelColor = {  default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 }},
      }
    )
    catTitle.x = 50
    catTitle.y = 50
    catTitle:addEventListener( "tap", backToMenu )
    sceneGroup:insert(catTitle)
    sceneGroup:insert(regGroup)

    loadAcc()

    regButton = widget.newButton(
      {
        labelXOffset = 5,
        label = "регистрация",
        labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
        labelAlign = "center",
        font = buttonsFont,
        fontSize = 25,
        shape = "rect",
        width = display.contentWidth*2/5,
        height = display.contentHeight/10,
        --height = 150,
        --cornerRadius = 8,
            --labelYOffset = -6,
            fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            strokeColor = { default={ 0, 0, 0, 0.2}, over={ 0.2, 0.2, 0.2 } },
            strokeWidth = 1,
        --fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
        onEvent = handleButtonEvent
      }
    )

    regButton.x = 140
    regButton.y = 180
    regButton.nummer = "chooseReg"
    regGroup:insert(regButton)

    loginButton = widget.newButton(
      {
        labelXOffset = 5,
        label = "вход",
        labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
        labelAlign = "center",
        font = buttonsFont,
        fontSize = 25,
        shape = "rect",
        width = display.contentWidth*2/5,
        height = display.contentHeight/10,
        --height = 150,
        --cornerRadius = 8,
            --labelYOffset = -6,
            fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            strokeColor = { default={ 0, 0, 0, 0.2}, over={ 0.2, 0.2, 0.2 } },
            strokeWidth = 1,
        --fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
        onEvent = handleButtonEvent
      }
    )

    loginButton.x = 400
    loginButton.y = 180
    loginButton.nummer = "chooseLogin"
    regGroup:insert(loginButton)

    userLabel = display.newText( regGroup, "Введите логин", display.contentCenterX, 320, buttonsFont, 25 )
    userLabel:setFillColor(0.5)
    userField = native.newTextField( display.contentCenterX, 390, 380, 60 )
    userField:addEventListener( "userInput", textListener )
    regGroup:insert(userField)

    passLabel = display.newText( regGroup, "Введите пароль", display.contentCenterX, 530, buttonsFont, 25 )
    passLabel:setFillColor(0.5)
    passField = native.newTextField( display.contentCenterX, 600, 380, 60 )
    passField:addEventListener( "userInput", textListener )
    passField.isSecure = true
    regGroup:insert(passField)

    sendRegButton = widget.newButton(
      {
        labelXOffset = 5,
        label = "зарегистрироваться",
        labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
        labelAlign = "center",
        font = buttonsFont,
        fontSize = 28,
        shape = "rect",
        width = display.contentWidth*3/4,
        height = display.contentHeight/10,
        --height = 150,
        --cornerRadius = 8,
            --labelYOffset = -6,
            fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            strokeColor = { default={ 0, 0, 0, 0.2}, over={ 0.2, 0.2, 0.2 } },
            strokeWidth = 1,
        --fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
        onEvent = handleButtonEvent
      }
    )

    sendRegButton.x = display.contentCenterX
    sendRegButton.y = 780
    sendRegButton.nummer = "sendReg"
    regGroup:insert(sendRegButton)

    sendLoginButton = widget.newButton(
      {
        labelXOffset = 5,
        label = "войти",
        labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
        labelAlign = "center",
        font = buttonsFont,
        fontSize = 28,
        shape = "rect",
        width = display.contentWidth*3/4,
        height = display.contentHeight/10,
        --height = 150,
        --cornerRadius = 8,
            --labelYOffset = -6,
            fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            strokeColor = { default={ 0, 0, 0, 0.2}, over={ 0.2, 0.2, 0.2 } },
            strokeWidth = 1,
        --fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
        onEvent = handleButtonEvent
      }
    )

    sendLoginButton.x = display.contentCenterX
    sendLoginButton.y = 780
    sendLoginButton.nummer = "sendLogin"
    sendLoginButton.isVisible = false
    regGroup:insert(sendLoginButton)

    result = display.newText( regGroup, "", display.contentCenterX, 920,
        display.contentWidth*0.7, 150, buttonsFont, 23 )
    result:setFillColor(0.5)
    result.text = "hello"

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
        composer.removeScene( "account" )
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