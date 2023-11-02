var _character
var _input
func _init(character):
	_character = character
	_input = character.getInput()
	character.animPlayer().play("Idle")
func update(delta : float):
	#print("idle")
	pass
	
func nextState():
	if !_character.is_on_floor():
		return load("res://fallState.gd").new(_character)
	if _input.isMoving():
		return load("res://walkState.gd").new(_character)
	if _input.isJumping():
		return load("res://jumpState.gd").new(_character)
	if _input.isPunching():
		return load("res://punch1State.gd").new(_character)
	return self
