-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local scene = composer.newScene()
local joystick = require "obj.joystick"
local border = require "obj.border"
local player = require "obj.player"
local tree = require "obj.tree"
local portal = require "obj.portal"

--------------------------------------------

-- forward declarations and other locals
local gameBorder, myStick, myPlayer, myPortal, xButton, yButton
local trees = {}

local function onEnterFrame( event )
	if myStick ~= nil then
		local angle = myStick:getAngle()

		local move = function(d)
			if myPlayer.walkingDirection ~= d then
				myPlayer.walkingDirection = d
				myPlayer:setSequence("walk_" .. d)
				myPlayer:play()
			end
		end

		local idle = function(d)
			myPlayer:setSequence("idle_" .. d)
			myPlayer:play()
		end

		if myStick.beingMoved then
			if (angle <= 45 or angle > 315) then
				myPlayer.y = myPlayer.y - 3
				move("up")
			elseif (angle <= 135 and angle > 45) then
				myPlayer.x = myPlayer.x + 3
				move("right")
			elseif (angle <= 225 and angle > 135) then
				myPlayer.y = myPlayer.y + 3
				move("down")
			elseif (angle <= 315 and angle > 225) then
				myPlayer.x = myPlayer.x - 3
				move("left")
			end
		else
			if myPlayer.walkingDirection ~= nil then
				if (myPlayer.walkingDirection == "up") then
					idle("up")
				elseif (myPlayer.walkingDirection == "right") then
					idle("right")
				elseif (myPlayer.walkingDirection == "down") then
					idle("down")
				elseif (myPlayer.walkingDirection == "left") then
					idle("left")
				end
			end
		end
	end
end

local function onRelease(event)
	if event.target.id == "X" then
		print("pressed 'X' button")
	elseif event.target.id == "Y" then
		print("pressed 'Y' button")
	end
end

local function onCollision(self, event)
	if event.phase == "began" then
		--print(event.other.type)
		if event.other.type == "tree" then
			print("collided with a tree")
		elseif event.other.type == "wall" then
			print("collided with a wall")
		elseif event.other.type == "portal" then
			print("collided with a portal")
		end
	end
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view
	physics.start()
	--physics.setDrawMode("hybrid") --uncomment this to see collision shapes
	physics.setGravity( 0, 0 )

	-- create gameBorder
	gameBorder = border.create("503008")

	-- create myPlayer
	myPlayer = player.create("assets/images/wizard.png")

	-- create trees
	for i=1, 78 do
		local x, y
		if (i == 1 or i == 2 or i == 3 or i == 4 or i == 5 or i == 6) then
			local dec = { 15, 45, 75, 105, 135, 165 }
			x = (centerX + (screenW / 2)) - dec[i]
			y = centerY
		elseif (i == 7 or i == 8 or i == 9 or i == 10 or i == 11 or i == 12) then
			local inc = { 15, 45, 75, 105, 135, 165 }
			x = (centerX - (screenW / 2)) + inc[i-6]
			y = centerY
		elseif (i == 13 or i == 14 or i == 15 or i == 16 or i == 17 or i == 18 or i == 19 or i == 20 or i == 21 or i == 22 or i == 23 or i == 24) then
			local inc = { 0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330 }
			x = centerX + inc[i-12]
			y = (centerY - (screenH / 2) + 10)
		elseif (i == 25 or i == 26 or i == 27 or i == 28 or i == 29 or i == 30 or i == 31 or i == 32 or i == 33 or i == 34 or i == 35 or i == 36) then
			local inc = { 0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330 }
			x = centerX + inc[i-24]
			y = (centerY - (screenH / 2) + 30)
		elseif (i == 37 or i == 38 or i == 39 or i == 40 or i == 41 or i == 42 or i == 43 or i == 44 or i == 45 or i == 46 or i == 47 or i == 48) then
			local inc = { 0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330 }
			x = centerX + inc[i-36]
			y = (centerY - (screenH / 2) + 50)
		elseif (i == 49 or i == 50 or i == 51 or i == 52 or i == 53 or i == 54 or i == 55 or i == 56 or i == 57 or i == 58 or i == 59 or i == 60) then
			local dec = { 0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330 }
			x = centerX - dec[i-48]
			y = (centerY + (screenH / 2) - 20)
		elseif (i == 61 or i == 62 or i == 63 or i == 64 or i == 65 or i == 66) then
			local dec = { 15, 45, 75, 105, 135, 165 }
			x = (centerX + (screenW / 2)) - dec[i - 60]
			y = centerY + 20
		elseif (i == 67 or i == 68 or i == 69 or i == 70 or i == 71 or i == 72) then
			local dec = { 15, 45, 75, 105, 135, 165 }
			x = (centerX + (screenW / 2)) - dec[i - 66]
			y = centerY + 40
		elseif (i == 73 or i == 74 or i == 75 or i == 76 or i == 77 or i == 78) then
			local dec = { 15, 45, 75, 105, 135, 165 }
			x = (centerX + (screenW / 2)) - dec[i - 72]
			y = centerY + 60
		end
		trees[i] = tree.create("summer", x, y, 32, 46)
	end

	-- create portal
	myPortal = portal.create((centerX - (screenW / 2)) + 45, (centerY - (screenH / 2)) + 30)

	-- create joystick
	myStick = joystick.NewStick({
        x = (centerX - (screenW / 2)) + 70,
        y = (centerY + (screenH / 2)) - 50,
        thumbSize = 16,
        borderSize = 32, 
        snapBackSpeed = .2, 
        R = 0, G = 0, B = 0,
	})

	-- create xButton
	xButton = widget.newButton{
		label="X", labelColor={ default={ 1.0 }, over={ 0.5 } },
		defaultFile="assets/images/circle-button-over.png",
		overFile="assets/images/circle-button-over.png",
		id="X", width=50, height=50, onRelease = onRelease
	}
	xButton.x = (centerX + (screenW / 2)) - 110
	xButton.y = (centerY + (screenH / 2)) - 50

	-- create yButton
	yButton = widget.newButton{
		label="Y", labelColor={ default={ 1.0 }, over={ 0.5 } },
		defaultFile="assets/images/circle-button-over.png",
		overFile="assets/images/circle-button-over.png",
		id="Y", width=50, height=50, onRelease = onRelease
	}
	yButton.x = (centerX + (screenW / 2)) - 50
	yButton.y = (centerY + (screenH / 2)) - 50

	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.
	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor(color.hex("503008"))
	
	-- all display objects must be inserted into group
	sceneGroup:insert(background)
	sceneGroup:insert(gameBorder)
	sceneGroup:insert(myPlayer)
	if trees then
		for i=1, #trees do
			sceneGroup:insert(trees[i])
		end
	end
	sceneGroup:insert(myPortal)
	sceneGroup:insert(xButton)
	sceneGroup:insert(yButton)
	sceneGroup:insert(myStick)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		Runtime:addEventListener("enterFrame", onEnterFrame)
		myPlayer.collision = onCollision
		myPlayer:addEventListener("collision", myPlayer)
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

	Runtime:removeEventListener("enterFrame", onEnterFrame)
	myPlayer:removeEventListener("collision", myPlayer)
	
	package.loaded[physics] = nil
	physics = nil

	if xButton then
		xButton:removeSelf()
		xButton = nil
	end

	if yButton then
		yButton:removeSelf()
		yButton = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene