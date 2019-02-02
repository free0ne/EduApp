
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

local category = composer.getVariable( "category" )
local level = composer.getVariable( "level" )
local boldFont = "BwModelicaBold.ttf"
local thinFont = "BwModelicaThin.ttf"
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function backToCats()
  composer.gotoScene( "stageChoose" )
end

local function transition_2_text(obj, text)
   obj.text = text
   transition.to(obj,{time=400,alpha=1})
end

local function networkListener( event )

    if ( event.isError ) then
        print( "Network error: ", event.response )
    else
        print ( "RESPONSE: " .. event.response )
    end
end

local function sendValues(category, level, value)
  local headers = {}

  headers["Content-Type"] = "application/x-www-form-urlencoded"
  headers["Accept-Language"] = "en-US"

  --local body = "id=1&size=small"
  local body = "id=1&lvl=cat"..tostring(category).."l"..tostring(level).."&value="..tostring(value)

  local params = {}
  params.headers = headers
  params.body = body

  network.request( "http://eduapp.pp/add.php", "POST", networkListener, params )
end

local function transition_2_button(obj, text)
   obj:setLabel(text)
   obj:setFillColor(248/255, 243/255, 255/255)
   obj:setEnabled(true)
   transition.to(obj,{time=200,alpha=1})

end

local function goBack( event )

  local phase = event.phase
  if ( "ended" == phase ) then
    composer.gotoScene( "stageChoose" )
  end
  return true
end

--local function changeTask(taskObj, buttonsArr, taskArr, taskNum, nummer, correct)
local function changeTask(taskObj, buttonsArr, taskArr, taskNum)
  if taskNum == 1 then
    taskObj.text = taskArr[taskNum]["taskText"]
    buttonsArr[0]:setLabel(taskArr[taskNum]["answer1"])
    buttonsArr[1]:setLabel(taskArr[taskNum]["answer2"])
    buttonsArr[2]:setLabel(taskArr[taskNum]["answer3"])
    buttonsArr[3]:setLabel(taskArr[taskNum]["answer4"])
  elseif taskNum <= #taskArr then
    transition.to(taskObj,{time=400,alpha=0.0,onComplete = function() transition_2_text(taskObj, taskArr[taskNum]["taskText"]) end})
    for i = 1,4 do
      local anst = "answer"..i
      --[[if nummer == i then
        if correct == nummer then
          --transition.to(buttonsArr[i-1].fill, { r=1, g=1, b=1, a=1, time=500, transition=easing.inCubic })
          buttonsArr[i-1]:setFillColor(0,1,0)
        else
          buttonsArr[i-1]:setFillColor(1,0,0)
        end
      end]]--
      buttonsArr[i-1]:setEnabled(false)
      transition.to(buttonsArr[i-1],{time=400,alpha=0.0,onComplete = function() transition_2_button(buttonsArr[i-1], taskArr[taskNum][anst]) end})
    end
  else
    for i = 1,4 do
      buttonsArr[i-1]:setEnabled(false)
      transition.to(buttonsArr[i-1],{time=500,alpha=0.0,onComplete = function() buttonsArr[i-1]:removeSelf(); end})
    end
    taskObj.text = "Это всё, отвечено верно: "..score
    sendValues(category, level, score)
    goBack = widget.newButton(
      {
        shape = "roundedRect",
        cornerRadius = 8,
        fillColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        --fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 0.4, 0.1, 0.2 } },
        --strokeWidth = 3,
        width = 300,
        height = 260,
        font = boldFont,
        label = "К уровням",
        fontSize = 32,
        labelColor = { default={ 0.5, 0.5, 0.5 }, over={ 0, 0, 0 } },
        onEvent = goBack,
      }
    )
    goBack.x = display.contentWidth/2
    goBack.y = 600

    sceneGroup:insert(goBack)
  end

end

local function handleButtonEvent( event )

  local phase = event.phase
  if ( "ended" == phase ) then
      nummer = event.target.nummer
      correct = myTaskArray[currentTask]["correct"]
      if tonumber(correct) == nummer then
        event.target:setFillColor(67/255, 106/255, 53/255)
        score = score + 1
      else
        event.target:setFillColor(150/255, 58/255, 68/255)
      end
      print("currentTask: "..currentTask.."; Answer: "..nummer.."; Correct: "..myTaskArray[currentTask]["correct"])
      currentTask = currentTask + 1
      --changeTask(task, answerButtons, myTaskArray, currentTask, nummer, tonumber(correct))
      changeTask(task, answerButtons, myTaskArray, currentTask)
  end
  return true
end

-- HIGH score
local function endGame()
    composer.setVariable( "finalScore", score )
    composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


-- create()
function scene:create( event )

	sceneGroup = self.view
  display.setDefault( "background", 1, 1, 1 )
	-- Code here runs when the scene is first created but has not yet appeared on screen

  currentTask = 0
  score = 0


  --local derText = "Category: "..category.."; level: "..level
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
  catTitle:addEventListener( "tap", backToCats )
  sceneGroup:insert(catTitle)

  ---------\\\\\\\\\\\\\\     SQL    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    local tasktable
    myTaskArray = {}
    local taskNummer = 0

    if category == 1 then
      tasktable = require("category1")
    elseif category == 2 then
      tasktable = require("category2")
    elseif category == 3 then
      tasktable = require("category3")
    elseif category == 4 then
      tasktable = require("category4")
    elseif category == 5 then
      tasktable = require("category5")
    end

    for i=1, #tasktable do
        if tonumber( tasktable[i]["level"] ) == level then
            taskNummer = taskNummer+1
            myTaskArray[taskNummer] = {}
            myTaskArray[taskNummer]["taskText"] = tasktable[i]["taskText"]
            myTaskArray[taskNummer]["answer1"] = tasktable[i]["answer1"]
            myTaskArray[taskNummer]["answer2"] = tasktable[i]["answer2"]
            myTaskArray[taskNummer]["answer3"] = tasktable[i]["answer3"]
            myTaskArray[taskNummer]["answer4"] = tasktable[i]["answer4"]
            myTaskArray[taskNummer]["correct"] = tonumber( tasktable[i]["correct"] )
        end
    end

    --[[local sqlite3 = require( "sqlite3" )
    local path = system.pathForFile( "tasks.db", system.DocumentsDirectory )
    local db = sqlite3.open( path )

    -- Handle the "applicationExit" event to close the database
    local function onSystemEvent( event )
        if ( event.type == "applicationExit" ) then
            db:close()
        end
    end

    local sql = "SELECT * FROM category"..category.." WHERE level = "..level

    for row in db:nrows(sql) do
      taskNummer = taskNummer+1
      myTaskArray[taskNummer] = {}
      myTaskArray[taskNummer]["taskText"] = row.tasktext
      myTaskArray[taskNummer]["answer1"] = row.answer1
      myTaskArray[taskNummer]["answer2"] = row.answer2
      myTaskArray[taskNummer]["answer3"] = row.answer3
      myTaskArray[taskNummer]["answer4"] = row.answer4
      myTaskArray[taskNummer]["correct"] = row.correct
      print(myTaskArray[taskNummer]["taskText"])
    end

    -- Setup the event listener to catch "applicationExit"
    Runtime:addEventListener( "system", onSystemEvent )]]--
  ------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  task = display.newText( sceneGroup, "taskText", display.contentWidth/2, 270, thinFont, 36 )
  task:setFillColor( 0.5, 0.5, 0.5 )

  answerButtons = {}
  local xx = 0
  local yy = 0
  for i = 0, 3 do
    answerButtons[i] = widget.newButton(
      {
        shape = "Rect",
        fillColor = { default={ 92/255, 46/255, 80/255 }, over={ 92/255, 46/255, 80/255 } },
        --fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 0.4, 0.1, 0.2 } },
        --strokeWidth = 3,
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } },
        width = 230,
        height = 100,
        label = "answer #"..i+1,
        fontSize = 40,
        font = thinFont,

        onEvent = handleButtonEvent,
      }
    )
    xx = 145 + ((i) % 2)*240
    yy = (i - (i%2))/2*110
    answerButtons[i].x = xx
    answerButtons[i].y = 750 + yy
    answerButtons[i].nummer = i+1

    sceneGroup:insert(answerButtons[i])
  end

  currentTask = currentTask + 1
  changeTask(task, answerButtons,myTaskArray, currentTask)

  --[[progressView = widget.newProgressView(
      {
          left = 0,
          top = 956,
          width = display.contentWidth,
          isAnimated = true
      }
  )
  progressView:setProgress( 0.0 )
  sceneGroup:insert(progressView)]]--


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
    composer.removeScene( "stage" )
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
