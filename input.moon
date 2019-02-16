class Action
	new: (name) =>
		@name = name
		@bound = {}
		@down = false
		@pressed = false
		@released = false
		@heldFor = 0

	bind: (key) =>
		table.insert @bound, key

	update: (dt) =>
		@pressed = false
		@released = false

		-- Test to see if any of the bound keys are down
		for key in *@bound
			if love.keyboard.isDown key
				-- Set pressed if necessary
				if not @pressed and not @down
					@pressed = true

				@down = true
				@heldFor += dt

				return

		-- Set released if necessary
		if not @released and @down
			@released = true

		@down = false
		@heldFor = 0

class Input
	new: =>
		@actions = {}

	bind: (key, action) =>
		-- Create action if it doesn't exist yet
		if not @actions[action]
			@actions[action] = Action action
		@actions[action]\bind key

	pressed: (action) => @actions[action].pressed

	released: (action) => @actions[action].released

	down: (action) => @actions[action].down

	heldFor: (action) => @actions[action].heldFor

	hasHeld: (action, duration) => @actions[action].heldFor >= duration

	update: (dt) =>
		for _, action in pairs @actions
			action\update dt

return Input