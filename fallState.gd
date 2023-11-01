var _character
var _input
func _init(character):
	_character = character
	_input = character.getInput()
	character.animPlayer().play("Fall")
	
func update(delta : float):
	_character.move(_input.moveInput())
	print("falling")
	
func nextState():
	if _character.isOnFloor():
		return load("res://landState.gd").new(_character)
	else: return self
