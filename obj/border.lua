local public = {}

public.create = function(c)
	local border = display.newGroup()

	local topBorder = display.newRect( centerX, (centerY - (screenH / 2)), screenW, 5 )
	topBorder.type = "wall"
	topBorder:setFillColor(color.hex(c))
	physics.addBody(topBorder, "static", { isSensor = false })
	border:insert(topBorder)

	local rightBorder = display.newRect( (centerX + (screenW / 2)), centerY, 5, screenH )
	rightBorder.type = "wall"
	rightBorder:setFillColor(color.hex(c))
	physics.addBody(rightBorder, "static", { isSensor = false })
	border:insert(rightBorder)

	local bottomBorder = display.newRect( centerX, (centerY + (screenH / 2)), screenW, 5 )
	bottomBorder.type = "wall"
	bottomBorder:setFillColor(color.hex(c))
	physics.addBody(bottomBorder, "static", { isSensor = false })
	border:insert(bottomBorder)

	local leftBorder = display.newRect( (centerX - (screenW / 2)), centerY, 5, screenH )
	leftBorder.type = "wall"
	leftBorder:setFillColor(color.hex(c))
	physics.addBody(leftBorder, "static", { isSensor = false })
	border:insert(leftBorder)

	return border
end

return public