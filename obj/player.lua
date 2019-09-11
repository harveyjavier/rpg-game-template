local public = {}

public.create = function(image)
	local player

	player = display.newSprite(
		graphics.newImageSheet( image, { width = 46, height = 46, numFrames = 12, border = 1} ),
		{
			{ name="idle_down", start=1, count=1, time=200, loopCount=1 },
			{ name="idle_left", start=12, count=1, time=200, loopCount=1 },
			{ name="idle_up", start=4, count=1, time=200, loopCount=1 },
			{ name="idle_right", start=7, count=1, time=200, loopCount=1 },

			{ name="attack_down", start=2, count=1, time=200, loopCount=1 },
			{ name="attack_left", start=11, count=1, time=200, loopCount=1 },
			{ name="attack_up", start=5, count=1, time=200, loopCount=1 },
			{ name="attack_right", start=8, count=1, time=200, loopCount=1 },

			{ name="walk_down", start=2, count=2, time=150, loopCount=0 },
			{ name="walk_left", start=10, count=2, time=150, loopCount=0 },
			{ name="walk_up", start=5, count=2, time=150, loopCount=0 },
			{ name="walk_right", start=8, count=2, time=150, loopCount=0 },
		}
	)
	player.x = centerX
	player.y = centerY
	player.type = type
	player.attacking = false
	player:setSequence("idle_down")
	player:play()
	player.isMovingUp = false
	player.isMovingDown = false
	player.isMovingLeft = false
	player.isMovingRight = false
	player.walkingDirection = "down"

	physics.addBody(player, "dynamic", {shape={-19, -23, 19, -23, 19, 23, -19, 23}})

	player.isSleepingAllowed = false
	player.isFixedRotation = true

	return player
end

return public