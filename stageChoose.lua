
local composer = require( "composer" )
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
  local category = 0
  local categoryName = "Название категории"

  local function backToMenu()
    composer.gotoScene( "menu" )
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
  elseif category == 2 then
    categoryName = "Тема 2"
  elseif category == 3 then
    categoryName = "Тема 3"
  elseif category == 4 then
    categoryName = "Тема 4"
  elseif category == 5 then
    categoryName = "Тема 5"
  elseif category == 6 then
    categoryName = "Тема 6"
  elseif category == 7 then
    categoryName = "Тема 7"
  end

------------------- обработка кнопок

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
  local catTitle = display.newText( sceneGroup, categoryName, display.contentWidth/2, 100, native.systemFont, 32 )
  catTitle:setFillColor( 0, 1, 0 )
  catTitle:addEventListener( "tap", backToMenu )

---------\\\\\\\\\\\\\\     SQL    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  -- local sqlite3 = require( "sqlite3" )
  -- Open "data.db". If the file doesn't exist, it will be created
  local path = system.pathForFile( "tasks.db", system.DocumentsDirectory )
  local db = sqlite3.open( path )

  -- Handle the "applicationExit" event to close the database
  local function onSystemEvent( event )
      if ( event.type == "applicationExit" ) then
          db:close()
      end
  end
  -- Print the SQLite version
  -- print( "SQLite version " .. sqlite3.version() )
  -- Print the table contents
  --[[for row in db:nrows("SELECT MAX(level) FROM category1") do
    local text = row.level .. " " .. row.tasktext
    local t = display.newText( text, 20, 30*row.id, nil, 16 )
    t:setFillColor( 1, 0, 1 )
    sceneGroup:insert(t)
  end]]--

  --[[local countsql = "select count(*) from category"..category
  for x in db:urows(countsql) do
    print(x)
  end]]--

  local sql = "SELECT MAX(level) FROM category"..category
  local max = 1
  for val in db:urows(sql) do
    max = val
  end
    print("Maxlevel is: "..max)
  -- local t = display.newText("Max: "..max, 50, 50, nil, 28)
  -- t:setTextColor(0,0,0)
  -- sceneGroup:insert(t)

  -- Setup the event listener to catch "applicationExit"
  Runtime:addEventListener( "system", onSystemEvent )
------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  local buttons = {}
  local xx = 0
  local yy = 0
  for i = 0, max-1 do
    buttons[i] = widget.newButton(
      {
        shape = "roundedRect",
        cornerRadius = 8,
        fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        --fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 0.4, 0.1, 0.2 } },
        --strokeWidth = 3,
        width = 90,
        height = 90,
        label = i+1,
        fontSize = 60,
        labelColor = { default={ 0.5, 0.1, 0.65 }, over={ 0, 0, 0 } },
        onEvent = handleButtonEvent,
      }
    )
    xx = 85 + ((i) % 3)*180
    yy = (i - (i%3))/4
    buttons[i].x = xx
    buttons[i].y = 210 + yy*180
    buttons[i].nummer = i+1

    sceneGroup:insert(buttons[i])
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
