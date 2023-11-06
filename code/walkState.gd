class_name WalkState

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
		return FallState.new(_character)
	if !_controller.isMoving():
		return IdleState.new(_character)
	if _controller.isJumping():
		return JumpState.new(_character)
	if _controller.isPunching():
		return PunchState.new(_character, 1 , _character.getComboLength())
	return self
