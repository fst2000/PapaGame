var _character
var _input
func _init(character):
	_character = character
	_input = character.getInput()
	character.animPlayer().play("Fall")
	
func update(delta : float):
	var moveSpeed = 4
	_character.move(_input.moveInput() * moveSpeed)
	#print("falling")
	
func nextState():
	if _character.isOnFloor():
		return load("res://landState.gd").new(_character)
	else: return self
