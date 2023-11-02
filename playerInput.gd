var _moveInput = Vector3.ZERO
var _player
func _init(player):
	_player = player

func isMoving():
	return moveInput().length() > 0
	
func moveInput() -> Vector3:
	var camRotation = _player.getCamRotation().y + PI
	return Vector3(
		Input.get_axis("right", "left"),
		0,
		Input.get_axis("down", "up")).rotated(Vector3.UP, camRotation).normalized()

func isPunching():
	return Input.is_action_pressed("punch")
	
func isKicking():
	return Input.is_action_pressed("kick")
	
func isJumping():
	return Input.is_action_pressed("jump")

func isAction():
	return Input.is_action_pressed("action")
