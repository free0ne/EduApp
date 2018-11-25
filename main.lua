--local bg = display.newImage("pics/bg2.jpg")
--bg.x = display.contentCenterX
--bg.y = display.contentCenterY

--display.setStatusBar(display.HiddenStatusBar)

display.setDefault( "background", 12/255, 110/255, 30/255 )
display.setDefault( "fillColor", 0, 0, 0 )

widthR = display.contentWidth - 60

rect1 = display.newRoundedRect( display.contentCenterX, 150, widthR, 80, 5 )
rect1:setFillColor(50/255, 0.7)
--useless
