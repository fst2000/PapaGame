var _character
var _controller
func _init(character):
	_character = character
	_controller = character.getController()
	character.animPlayer().play("Walk")
	
func update(delta : float):
	var moveSpeed = 4
	_character.move(_controller.moveDirection() * moveSpeed)
	#print("walk")
	
func nextState():
	if !_character.is_on_floor():
		return load("res://fallState.gd").new(_character)
	if !_controller.isMoving():
		return load("res://idleState.gd").new(_character)
	if _controller.isJumping():
		return load("res://jumpState.gd").new(_character)
	if _controller.isPunching():
		return load("res://punch1State.gd").new(_character)
	return self
