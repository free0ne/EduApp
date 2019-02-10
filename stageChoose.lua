

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

  local category = 0
  local color
  local categoryName = "Название категории"
  local response = ""
  local results = {}
  local buttons = {}
  local pos = 0
  local boldFont = "BwModelicaBold.ttf"
  local thinFont = "BwModelicaThin.ttf"

  --highscores
  local json = require( "json" )
  local scoresTable = {}
  local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )


  local function backToMenu()
    composer.gotoScene( "menu" )
  end

  --[[local function networkListener( event )
    for i = 0, 2 do
      results[i] = "0/10"
    end
    if ( event.isError ) then
        print( "Network error: ", event.response )
    else
        --print ( "RESPONSE: " .. event.response )
        response = event.response
        print (response)
        for i in string.gmatch(response, "%S+") do
           results[pos] = i
           pos = pos + 1
        end
        pos = 0
        for i = 0, 2 do
          buttons[i]:setLabel(" "..tostring(i+1).."\n"..results[i].."/9")
        end
    end
  end]]--

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function handleButtonEvent( event )

  local phase = event.phase
  if ( "ended" == phase ) then
      nummer = event.target.nummer
      --!!передача данных в другую сцену

      composer.setVariable( "level", nummer )
      composer.setVariable( "category", category )
      print("Category: "..category.."; level: "..nummer)
      composer.gotoScene( "stage" )
  end
  --сраное всплывающее окно, где по идее должен быть общий текст задания
  local options =
  {
  isModal = true,
  effect = "fade",
  time = 1000,
  }

  -- By some method such as a "pause" button, show the overlay
  composer.showOverlay( "globalTusk", options )

  --[[if ( phase == "moved" ) then
      local dy = math.abs( ( event.y - event.yStart ) )
      -- If the touch on the button has moved more than 10 pixels,
      -- pass focus back to the scroll view so it can continue scrolling
      if ( dy > 10 ) then
          scrollView:takeFocus( event )
      end
  end]]--
  return true
end

local function loadScores()

    local file = io.open( filePath, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
        scoresTable = json.decode( contents )
    end

    if ( scoresTable == nil or #scoresTable == 0 ) then
        scoresTable = { {{ 0, 0, 0, 0, 0, 0 }, {9, 9, 9, 9, 9, 9}}, {{0, 0}, {9, 9}}, }
    end
end
-- create()
function scene:create( event )
    display.setStatusBar( display.HiddenStatusBar )
	local sceneGroup = self.view
  display.setDefault( "background", 1, 1, 1 )
	-- Code here runs when the scene is first created but has not yet appeared on screen
  category = composer.getVariable( "stageNummer" )
  if category == 1 then
    categoryName = "Системы счисления"

  elseif category == 2 then
    categoryName = "Маски для выбора файлов"
    color = { 157/255,106/255,189/255 }
  elseif category == 3 then
    categoryName = "Условие Фано"
    color = { 172/255,120/255,164/255 }
  elseif category == 4 then
    categoryName = "Тема 4"
    color = { 182/255,129/255,145/255 }
  elseif category == 5 then
    categoryName = "Тема 5"
    color = { 194/255,140/255,125/255 }
  elseif category == 6 then
    categoryName = "Тема 6"
    color = { 207/255,152/255,103/255 }
  elseif category == 7 then
    categoryName = "Тема 7"
    color = { 219/255,168/255,103/255 }
  end
------------------- обработка кнопок
--rectLvl:setFillColor(243/255, 248/255, 1)
--rectLvl:setStrokeColor (1, 0, 0)
--rectLvl.strokeWidth = 2


 -----------------------------------------------
  -- не забывай добавлять в группы! (sceneGroup)
  local upperRectangle = display.newRect( sceneGroup,display.contentWidth/2, 70, display.contentWidth, 140 )
  upperRectangle:setFillColor( 1, 1, 1 )

  local catTitle = widget.newButton(
    {
      shape = "rect",
      labelAlign = "left",
      labelXOffset = 3,
      labelYOffset = -5,
    --  width = display.contentWidth/4*3,
        width = display.contentWidth,
      height = 140,
      label = categoryName,
      font = boldFont,
      fontSize = 35,
      labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
    }
  )
  catTitle.x = 280
  catTitle.y = 40

  --catTitle:setFillColor(0,0,0,0.1)
  sceneGroup:insert(catTitle)
  catTitle:addEventListener( "tap", backToMenu )

  local help = widget.newButton(
    {
      shape = "circle",
      radius = 40,
      label = "?",
      font = boldFont,
      fontSize = 60,
      fillColor = { default={ 117/255, 58/255, 68/255 }, over={ 117/255, 58/255, 68/255 } },
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
      onPress = function(event)
        composer.showOverlay( "help" , {
          isModal = true,
          effect = "fade",
          time = 400,
        } )
      end
    }
  )
  help.x = 500
  help.y = 40
  help:scale(0.7, 0.7)
  sceneGroup:insert(help)

---------\\\\\\\\\\\\\\     SQL    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



  local max = 1
  local tasktable

  if category == 1 then
      tasktable = require("category1")

      for i=1, #tasktable do
          if tonumber( tasktable[i]["level"] ) > max then
              max = tonumber( tasktable[i]["level"] )
          end
      end
  elseif category == 2 then
      tasktable = require("category2")

      for i=1, #tasktable do
          if tonumber( tasktable[i]["level"] ) > max then
              max = tonumber( tasktable[i]["level"] )
          end
      end
  elseif category == 3 then
      tasktable = require("category3")

      for i=1, #tasktable do
          if tonumber( tasktable[i]["level"] ) > max then
              max = tonumber( tasktable[i]["level"] )
          end
      end
  elseif category == 4 then
      tasktable = require("category4")

      for i=1, #tasktable do
          if tonumber( tasktable[i]["level"] ) > max then
              max = tonumber( tasktable[i]["level"] )
          end
      end
    elseif category == 5 then
        tasktable = require("category5")

        for i=1, #tasktable do
            if tonumber( tasktable[i]["level"] ) > max then
                max = tonumber( tasktable[i]["level"] )
            end
        end
  end


  print("Maxlevel by table is: "..max)

------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  local xx = 0
  local yy = 0
  local xOffset = 150
  local yOffset = 290
  local cellCount = 1
  loadScores()
  for i = 0, max-1 do
    buttons[i] = widget.newButton(
      {
        shape = "Rect",
        --fillColor = { default={ 0.95, 0.96, 1 }, over={ 0.68, 0.45, 0.95 } },
        width = 235,
        height = 235,
        label = tostring( tostring( i+1 ).."\n"..scoresTable[category][1][i+1].." из "..scoresTable[category][2][i+1] ),
        font = boldFont,
        fontSize = 60,
        labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
        cornerRadius = 8,
        fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        strokeColor = { default={ 0, 0, 0, 0.2}, over={ 0.2, 0.2, 0.2 } },
        strokeWidth = 1,

        onEvent = handleButtonEvent

      }

    )



    --xx = 150 + ((i) % 3)*250
    --yy = (i - (i%3))/4
   buttons[i].x = xOffset
   buttons[i].y = yOffset
   buttons[i].nummer = i+1


   sceneGroup:insert(buttons[i])

    xOffset = xOffset + 250
    cellCount = cellCount + 1
      if (cellCount > 2 ) then
        cellCount = 1
        xOffset = 150
        yOffset = yOffset + 250
      end


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
