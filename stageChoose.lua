

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

  local function backToMenu()
    composer.gotoScene( "menu" )
  end

  local function networkListener( event )
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
  end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
  display.setDefault( "background", 1, 1, 1 )
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local category = composer.getVariable( "stageNummer" )
  if category == 1 then
    categoryName = "Системы счисления"
    color = { 143/255,93/255,213/255 }
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
 -----------------------------------------------
  -- не забывай добавлять в группы! (sceneGroup)
  local upperRectangle = display.newRect( sceneGroup,display.contentWidth/2, 70, display.contentWidth, 140 )
  upperRectangle:setFillColor(173/255, 123/255, 243/255)
  --[[local paint = {
    type = "gradient",
    color1 = color,
    color2 = { 1, 1, 1 },
    direction = "down"
  }]]--
  --upperRectangle:setFillColor(paint)

  local catTitle = widget.newButton(
    {
      shape = "rect",
      labelAlign = "left",
      labelXOffset = 3,
      labelYOffset = -5,
      width = display.contentWidth/4*3,
      height = 140,
      label = categoryName,
      font = "displayOTF.ttf",
      fontSize = 42,
      labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
    }
  )
  catTitle.x = 200
  catTitle.y = 70

  catTitle:setFillColor(0,0,0,0.1)
  sceneGroup:insert(catTitle)
  catTitle:addEventListener( "tap", backToMenu )

  local help = widget.newButton(
    {
      shape = "circle",
      radius = 40,
      label = "?",
      font = "displayOTF.ttf",
      fontSize = 45,
      fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1 } },
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
  help.y = 70
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


  --[[

  local sqlite3 = require( "sqlite3" )
  local path = system.pathForFile( "tasks.db", system.DocumentsDirectory )
  local db = sqlite3.open( path )

  -- Handle the "applicationExit" event to close the database
  local function onSystemEvent( event )
      if ( event.type == "applicationExit" ) then
          db:close()
      end
  end

  local sql = "SELECT MAX(level) FROM category"..category

  for val in db:urows(sql) do
    max = val
  end
    print("Maxlevel is: "..max)
  Runtime:addEventListener( "system", onSystemEvent )]]--
------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  local xx = 0
  local yy = 0
  local xOffset = 150
  local yOffset = 290
  local cellCount = 1
  for i = 0, max-1 do
    buttons[i] = widget.newButton(
      {
        shape = "Rect",
        fillColor = { default={ 0.95, 0.96, 1 }, over={ 0.68, 0.45, 0.95 } },
        width = 235,
        height = 235,
        label = tostring( i+1 ),
        font = "displayOTF.ttf",
        fontSize = 60,
        labelColor = { default={ 0.5, 0.1, 0.65 }, over={ 0.3, 0, 0.75 } },

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


  local headers = {}

  headers["Content-Type"] = "application/x-www-form-urlencoded"
  headers["Accept-Language"] = "en-US"

  --local body = "id=1&size=small"
  local body = ""

  local params = {}
  params.headers = headers
  params.body = body

  network.request( "http://eduapp.pp/index.php", "POST", networkListener, params )


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
