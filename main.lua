-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- global variables
composer = require "composer"
physics = require "physics"
widget = require "widget"
loadsave = require "lib.loadsave"
color = require "lib.convertcolor"
inspect = require "lib.inspect"

screenW = display.actualContentWidth
screenH = display.actualContentHeight
centerX = display.contentCenterX
centerY = display.contentCenterY

-- load menu screen
composer.gotoScene( "scenes.game" )