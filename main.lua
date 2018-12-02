--[[


widthR = display.contentWidth - 60

rect1 = display.newRoundedRect( display.contentCenterX, 150, widthR, 80, 5 )
rect1:setFillColor(50/255, 0.7)--]]

local composer = require( "composer" )

-- Hide status bar
--display.setStatusBar( display.HiddenStatusBar )

-- Go to the menu screen
composer.gotoScene( "menu" )
