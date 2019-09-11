local public = {}

public.create = function(x, y)
	local portal
	portal = display.newSprite(graphics.newImageSheet("assets/images/portal.png", {width = 73, height = 48, numFrames = 9}), {name = "idle", start=1, count=9, time=500})
	portal.x = x
	portal.y = y
	portal.type = "portal"
	portal:play()

	physics.addBody(portal, "static", {shape={-19, -10, 19, -10, 19, 10, -19, 10}})
	portal.isSleepingAllowed = false

	return portal
end

return public