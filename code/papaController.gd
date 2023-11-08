class_name PapaController

var papa
func _init(papa):
	self.papa = papa

func shouldMove():
	return moveInput().length() > 0.1
	
func moveDirection() -> Vector3:
	var camRotation = papa.camera.rotation.y + PI
	var moveInput = moveInput()
	if moveInput.length() > 0.01:
		var moveDir = moveInput.rotated(Vector3.UP, camRotation).normalized()
		var smoothDir = moveDir
		var forward = Vector3.BACK.rotated(Vector3.UP, papa.rotation.y)
		if forward.angle_to(moveDir) >= 3.14:
			smoothDir = smoothDir.rotated(Vector3.UP, 0.1)
		else:
			smoothDir = lerp(forward, moveDir, 0.3)
		return smoothDir
	else: return papa.forward()

func shouldPunch():
	return Input.is_action_pressed("punch")
	
func shouldKick():
	return Input.is_action_pressed("kick")

func shouldAttack():
	return shouldPunch() || shouldKick()

func shouldJump():
	return Input.is_action_pressed("jump")

func shouldAct():
	return Input.is_action_pressed("action")
	
func moveInput() -> Vector3:
	return Vector3(
		Input.get_axis("right", "left"),
		0,
		Input.get_axis("down", "up"))
