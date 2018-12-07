
local composer = require( "composer" )
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )

local scene = composer.newScene()

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

local function transition_2_button(obj, text)
   obj:setLabel(text)
   obj:setFillColor(0.2, 1, 1)
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

local function changeTask(taskObj, buttonsArr, taskArr, taskNum, nummer, correct)
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
    goBack = widget.newButton(
      {
        shape = "roundedRect",
        cornerRadius = 8,
        fillColor = { default={ 0.2, 1, 1 }, over={ 0.2, 1, 1 } },
        --fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 0.4, 0.1, 0.2 } },
        --strokeWidth = 3,
        width = 300,
        height = 260,
        label = "К уровням",
        fontSize = 32,
        labelColor = { default={ 0.5, 0.1, 0.65 }, over={ 0, 0, 0 } },
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
        event.target:setFillColor(0,1,0)
        score = score + 1
      else
        event.target:setFillColor(1,0,0)
      end
      print("currentTask: "..currentTask.."; Answer: "..nummer.."; Correct: "..myTaskArray[currentTask]["correct"])
      currentTask = currentTask + 1
      changeTask(task, answerButtons, myTaskArray, currentTask, nummer, tonumber(correct))
  end
  return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


-- create()
function scene:create( event )

	sceneGroup = self.view
  display.setDefault( "background", 0.5, 0.6, 0.3 )
	-- Code here runs when the scene is first created but has not yet appeared on screen

  local category = composer.getVariable( "category" )
  local level = composer.getVariable( "level" )

  currentTask = 0
  score = 0

  local derText = "Category: "..category.."; level: "..level
  local catTitle = display.newText( sceneGroup, derText, display.contentWidth/2, 100, native.systemFont, 32 )
  catTitle:setFillColor( 0, 1, 0 )
  catTitle:addEventListener( "tap", backToCats )

  ---------\\\\\\\\\\\\\\     SQL    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    local path = system.pathForFile( "tasks.db", system.DocumentsDirectory )
    local db = sqlite3.open( path )

    -- Handle the "applicationExit" event to close the database
    local function onSystemEvent( event )
        if ( event.type == "applicationExit" ) then
            db:close()
        end
    end


    local sql = "SELECT * FROM category"..category.." WHERE level = "..level
    myTaskArray = {}
    local taskNummer = 0
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
    Runtime:addEventListener( "system", onSystemEvent )
  ------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  task = display.newText( sceneGroup, "taskText", display.contentWidth/2, 300, nil, 36 )
  task:setFillColor( 0.5, 0.2, 1 )

  answerButtons = {}
  local xx = 0
  local yy = 0
  for i = 0, 3 do
    answerButtons[i] = widget.newButton(
      {
        shape = "roundedRect",
        cornerRadius = 8,
        fillColor = { default={ 0.2, 1, 1 }, over={ 0.2, 1, 1 } },
        --fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
        --strokeColor = { default={ 1, 1, 1 }, over={ 0.4, 0.1, 0.2 } },
        --strokeWidth = 3,
        width = 200,
        height = 160,
        label = "answer #"..i+1,
        fontSize = 22,
        labelColor = { default={ 0.5, 0.1, 0.65 }, over={ 0, 0, 0 } },
        onEvent = handleButtonEvent,
      }
    )
    xx = 140 + ((i) % 2)*280
    yy = (i - (i%2))/2*250
    answerButtons[i].x = xx
    answerButtons[i].y = 550 + yy
    answerButtons[i].nummer = i+1

    sceneGroup:insert(answerButtons[i])
  end

  currentTask = currentTask + 1
  changeTask(task, answerButtons,myTaskArray, currentTask)

  --[[local label = display.newText(sceneGroup,"Label_1",50,100,nil,20)
  label:setTextColor(0,0,1)

  local function transition_2()
     label.text = "Label_2"
     transition.to(label,{time=1000,alpha=1})
  end
  transition.to(label,{time=1000,alpha=0,onComplete=transition_2})]]--



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
