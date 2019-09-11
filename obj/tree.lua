local public = {}

public.create = function(t, x, y, w, h)
	local tree = display.newImageRect( "assets/images/pine-tree-" .. t .. ".png", w, h )
	tree.x = x
	tree.y = y
	tree.type = "tree"

	local physics_body = {}
	physics_body["tree"] = {
        {
        	density = 2, friction = 0, bounce = 0, 
        	filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
        	shape = { -14, -4.5, 0.5, -23 , 0.5, -22, -6, 21.5, -15.5, 15 }
        }
         ,
        {
        	density = 2, friction = 0, bounce = 0, 
        	filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
        	shape = { 6.5, 22, -6, 21.5 , 0.5, -22, 15, -0.5, 13.5, 17 }
        }
	}
	physics.addBody(tree, "static", unpack(physics_body["tree"]))

	return tree
end

return public