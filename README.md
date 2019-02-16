# hmbg-input

Tiny LÖVE input library written in MoonScript.

## Usage

```moon
export input = (require "input")!

love.load = ->
	input\bind "left", "move_left"
	input\bind "right", "move_right"
	-- bind multiple keys to one action
	input\bind "space", "jump"
	input\bind "up", "jump"
	input\bind "shift", "charge"

love.update = (dt) ->
	-- remember to always call update!
	input\update dt

	-- pressed only returns true once after the key is pressed
	if input\pressed "jump"
		print "jumped!"
	-- same for released
	elseif input\released "jump"
		print "stopped jumping."

	-- check if charging for 5 seconds
	if input\hasHeld "charge", 5
		print "charged!"
```

## Todo

- [ ] Unbinding keys
- [ ] Joystick support
- [ ] Mouse support
- [ ] Better error handling