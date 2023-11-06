class_name IdleState

var _character
var _controller
func _init(character):
	_character = character
	_controller = character.getController()
	character.animPlayer().play("Idle")
func update(delta : float):
	#print("idle")
	pass
	
func nextState():
	if !_character.is_on_floor():
		return FallState.new(_character)
	if _controller.isPunching():
		return PunchState.new(_character, 1, _character.getComboLength())
	if _controller.isMoving():
		return WalkState.new(_character)
	if _controller.isJumping():
		return JumpState.new(_character)
	return self
