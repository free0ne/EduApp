local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local buttonsFont = "displayOTF.ttf"
local buttonsFontSize = 45

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
      font = "displayOTF.ttf",
      fontSize = 45,
      fillColor = { default={ 0, 0, 0, 0.4 }, over={ 0, 0, 0, 0.4 } },
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
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        labelAlign = "left",
        font = buttonsFont,
        fontSize = 45,
        shape = "rect",
        width = display.contentWidth,
        height = display.contentHeight/6,
        --fillColor = { default={173/255,123/255,243/255,1}, over={173/255,123/255,243/255,1} },
        onEvent = handleButtonEvent
      }
    )

    buttons[i].x = display.contentCenterX
    buttons[i].y = 80 + 80 + i*160
    buttons[i].nummer = i+1

      if i == 0 then
        buttons[i]:setLabel("Системы\nсчисления")
        buttons[i]:setFillColor( 173/255,123/255,243/255 )
      elseif i == 1 then
        buttons[i]:setLabel("Таблицы\nистинности")
        buttons[i]:setFillColor( 187/255,136/255,219/255 )
      elseif i == 2 then
        buttons[i]:setLabel("Анализ моделей")
        buttons[i]:setFillColor( 202/255,150/255,194/255 )
      elseif i == 3 then
        buttons[i]:setLabel("Поиск информации\nв базе данных")
        buttons[i]:setFillColor( 212/255,159/255,175/255 )
      elseif i == 4 then
        buttons[i]:setLabel("Маски для\nвыбора файлов")
        buttons[i]:setFillColor( 224/255,170/255,155/255 )
      elseif i == 5 then
        buttons[i]:setLabel("Кодирование и\nдекодирование")
        buttons[i]:setFillColor( 237/255,182/255,133/255 )
        -----------------------------------------------------
      elseif i == 6 then
        buttons[i]:setLabel("Выполнение и анализ\nпростых алгоритмов")
        buttons[i]:setFillColor( 249/255,198/255,133/255 )
      elseif i == 7 then
        buttons[i]:setLabel("Анализ и построение\nалгоритмов")
        buttons[i]:setFillColor( 230/255,206/255,151/255 )
      elseif i == 8 then
        buttons[i]:setLabel("Электронные\nтаблицы")
        buttons[i]:setFillColor( 206/255,217/255,174/255 )
      elseif i == 9 then
        buttons[i]:setLabel("Диаграммы в\nтаблицах")
        buttons[i]:setFillColor( 186/255,227/255,194/255 )
      elseif i == 10 then
        buttons[i]:setLabel("Анализ программ\nс циклами")
        buttons[i]:setFillColor( 163/255,237/255,216/255 )
      elseif i == 11 then
        buttons[i]:setLabel("Кодирование\nизображений")
        buttons[i]:setFillColor( 141/255,247/255,237/255 )
        ----------------------------------------------------
      elseif i == 12 then
        buttons[i]:setLabel("Кодирование звука")
        buttons[i]:setFillColor( 134/255,246/255,246/255 )
      elseif i == 13 then
        buttons[i]:setLabel("Скорость передачи\nданных")
        buttons[i]:setFillColor( 142/255,222/255,247/255 )
      elseif i == 14 then
        buttons[i]:setLabel("Кодирование\nсообщений")
        buttons[i]:setFillColor( 149/255,203/255,248/255 )
      elseif i == 15 then
        buttons[i]:setLabel("Составление слов")
        buttons[i]:setFillColor( 156/255,183/255,249/255 )
      elseif i == 16 then
        buttons[i]:setLabel("Слова в\nалфавитном порядке")
        buttons[i]:setFillColor( 163/255,161/255,250/255 )
      elseif i == 17 then
        buttons[i]:setLabel("Рекурсивные\nалгоритмы")
        buttons[i]:setFillColor( 170/255,140/255,251/255 )
        -------------------------------------------------------
      elseif i == 18 then
        buttons[i]:setLabel("Адресация в сетях\nTCP/IP")
        buttons[i]:setFillColor( 173/255,123/255,243/255 )
      elseif i == 19 then
        buttons[i]:setLabel("Вычисление количества\nинформации")
        buttons[i]:setFillColor( 187/255,136/255,219/255 )
      elseif i == 20 then
        buttons[i]:setLabel("Анализ алгоритма\nдля Чертёжника")
        buttons[i]:setFillColor( 202/255,150/255,194/255 )
      elseif i == 21 then
        buttons[i]:setLabel("Анализ алгоритма\nдля Редактора")
        buttons[i]:setFillColor( 212/255,159/255,175/255 )
      elseif i == 22 then
        buttons[i]:setLabel("Поиск путей\nв графах")
        buttons[i]:setFillColor( 224/255,170/255,155/255 )
      elseif i == 23 then
        buttons[i]:setLabel("Позиционные\nсистемы счисления")
        buttons[i]:setFillColor( 237/255,182/255,133/255 )
        -------------------------------------------------------
      elseif i == 24 then
        buttons[i]:setLabel("Запросы в\nпоисковых системах")
        buttons[i]:setFillColor( 249/255,198/255,133/255 )
      elseif i == 25 then
        buttons[i]:setLabel("Логические выражения\nи множества")
        buttons[i]:setFillColor( 230/255,206/255,151/255 )
      elseif i == 26 then
        buttons[i]:setLabel("Логика и линейное\nпрограммирование")
        buttons[i]:setFillColor( 206/255,217/255,174/255 )
      elseif i == 27 then
        buttons[i]:setLabel("Обработка массивов")
        buttons[i]:setFillColor( 186/255,227/255,194/255 )
      elseif i == 28 then
        buttons[i]:setLabel("Циклы и\nветвления")
        buttons[i]:setFillColor( 163/255,237/255,216/255 )
      elseif i == 29 then
        buttons[i]:setLabel("Циклы и\nподпрограммы")
        buttons[i]:setFillColor( 141/255,247/255,237/255 )
        ------------------------------------------------------
      elseif i == 30 then
        buttons[i]:setLabel("Динамическое\nпрограммирование")
        buttons[i]:setFillColor( 134/255,246/255,246/255 )
      elseif i == 31 then
        buttons[i]:setLabel("Системы\nлогических уравнений")
        buttons[i]:setFillColor( 142/255,222/255,247/255 )
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
