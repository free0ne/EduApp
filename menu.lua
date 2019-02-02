local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local buttonsFont = "BwModelicaBold.ttf"
--local buttonsFontSize = 25

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
----------------------------------------------------------.......................
--тут из старой базы в тейблы дёргаю

  --[[local sqlite3 = require( "sqlite3" )
  local path = system.pathForFile( "tasks.db", system.DocumentsDirectory )
  local db = sqlite3.open( path )
  local filePath = system.pathForFile( "category2.txt", system.DocumentsDirectory )
  local file = io.open( filePath, "w" )

  local function onSystemEvent( event )
      if ( event.type == "applicationExit" ) then
          db:close()
      end
  end

  local totstr = "{ "
  local sql = "SELECT * FROM category2"
  --myTaskArray = {}
  --local taskNummer = 0
  for row in db:nrows(sql) do
    -- totstr = totstr.."{ id = \""..row.id.."\", "
    totstr = totstr.."{ level = \""..row.level.."\", "
    totstr = totstr.."tasknummer = \""..row.tasknummer.."\", "
    totstr = totstr.."taskText = \""..row.tasktext.."\", "
    totstr = totstr.."answer1 = \""..row.answer1.."\", "
    totstr = totstr.."answer2 = \""..row.answer2.."\", "
    totstr = totstr.."answer3 = \""..row.answer3.."\", "
    totstr = totstr.."answer4 = \""..row.answer4.."\", "
    totstr = totstr.."correct = \""..row.correct.."\" }, "
    --myTaskArray[taskNummer]["correct"] = row.correct
    --print(myTaskArray[taskNummer]["taskText"])

  end
  totstr = totstr.." }"
  print(totstr)
  if file then
        file:write( totstr )
        io.close( file )
    end

  -- Setup the event listener to catch "applicationExit"
  Runtime:addEventListener( "system", onSystemEvent )]]--

----------------------------------------------------------.......................
    -- Create the widget
  local scrollView = widget.newScrollView(
      {
          top = 0,
          left = 0,
          width = display.contentWidth,
          height = display.contentHeight,
          scrollWidth = 540,
          scrollHeight = 80+160*7, --*количество кнопок
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
  local help = widget.newButton(
    {
      shape = "circle",
      radius = 40,
      label = "?",
      font = buttonsFont,
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
  scrollView:insert(help)

  -- create buttons array
  local buttons = {}
  for i = 0, 31 do
    buttons[i] = widget.newButton(
      {
        labelXOffset = 5,
        label = "categoryName",
        labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
        labelAlign = "left",
        font = buttonsFont,
        fontSize = 35,
        shape = "rect",
        width = display.contentWidth,
        height = display.contentHeight/6,
        --height = 150,
        cornerRadius = 8,
            --labelYOffset = -6,
            fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
            strokeColor = { default={ 0, 0, 0, 0.2}, over={ 0.2, 0.2, 0.2 } },
            strokeWidth = 1,
        --fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
        onEvent = handleButtonEvent
      }
    )

    buttons[i].x = display.contentCenterX
    buttons[i].y = 80 + 80 + i*160
    buttons[i].nummer = i+1

      if i == 0 then
        buttons[i]:setLabel("Системы счисления")
        elseif i == 1 then
        buttons[i]:setLabel("Маски для выбора файлов")
      elseif i == 2 then
        buttons[i]:setLabel("Условие Фано")
      elseif i == 3 then
        buttons[i]:setLabel("Таблицы истинности")
      elseif i == 4 then
        buttons[i]:setLabel("Анализ моделей")
      elseif i == 5 then
        buttons[i]:setLabel("Кодирование и\nдекодирование")
        -----------------------------------------------------
      elseif i == 6 then
        buttons[i]:setLabel("Выполнение и анализ\nпростых алгоритмов")
      elseif i == 7 then
        buttons[i]:setLabel("Анализ и построение\nалгоритмов")
      elseif i == 8 then
        buttons[i]:setLabel("Электронные\nтаблицы")
      elseif i == 9 then
        buttons[i]:setLabel("Диаграммы в\nтаблицах")
      elseif i == 10 then
        buttons[i]:setLabel("Анализ программ\nс циклами")
      elseif i == 11 then
        buttons[i]:setLabel("Кодирование\nизображений")
        ----------------------------------------------------
      elseif i == 12 then
        buttons[i]:setLabel("Кодирование звука")
      elseif i == 13 then
        buttons[i]:setLabel("Скорость передачи\nданных")
      elseif i == 14 then
        buttons[i]:setLabel("Кодирование\nсообщений")
      elseif i == 15 then
        buttons[i]:setLabel("Составление слов")
      elseif i == 16 then
        buttons[i]:setLabel("Слова в\nалфавитном порядке")
      elseif i == 17 then
        buttons[i]:setLabel("Рекурсивные\nалгоритмы")
        -------------------------------------------------------
      elseif i == 18 then
        buttons[i]:setLabel("Адресация в сетях\nTCP/IP")
      elseif i == 19 then
        buttons[i]:setLabel("Вычисление количества\nинформации")
      elseif i == 20 then
        buttons[i]:setLabel("Анализ алгоритма\nдля Чертёжника")
      elseif i == 21 then
        buttons[i]:setLabel("Анализ алгоритма\nдля Редактора")
      elseif i == 22 then
        buttons[i]:setLabel("Поиск путей\nв графах")
      elseif i == 23 then
        buttons[i]:setLabel("Позиционные\nсистемы счисления")
        -------------------------------------------------------
      elseif i == 24 then
        buttons[i]:setLabel("Запросы в\nпоисковых системах")
      elseif i == 25 then
        buttons[i]:setLabel("Логические выражения\nи множества")
      elseif i == 26 then
        buttons[i]:setLabel("Логика и линейное\nпрограммирование")
      elseif i == 27 then
        buttons[i]:setLabel("Обработка массивов")
      elseif i == 28 then
        buttons[i]:setLabel("Циклы и\nветвления")
      elseif i == 29 then
        buttons[i]:setLabel("Циклы и\nподпрограммы")
        ------------------------------------------------------
      elseif i == 30 then
        buttons[i]:setLabel("Динамическое\nпрограммирование")
      elseif i == 31 then
        buttons[i]:setLabel("Системы\nлогических уравнений")
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
