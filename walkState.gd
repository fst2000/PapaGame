var _character
var _input
func _init(character):
	_character = character
	_input = character.getInput()
	character.animPlayer().play("Walk")
	
func update(delta : float):
	_character.move(_input.moveInput())
	print("walk")
	
func nextState():
	if !_character.is_on_floor():
		return load("res://fallState.gd").new(_character)
	if !_input.isMoving():
		return load("res://idleState.gd").new(_character)
	if _input.isJumping():
		return load("res://jumpState.gd").new(_character)
	return self
