class_name PapaController

var papa
var is_active = true;

func _init(papa):
	self.papa = papa

func shouldMove():
	return moveInput().length() > 0.1 && is_active
	
func moveDirection() -> Vector3:
	var moveInput = moveInput()
	if moveInput.length() > 0.01 && is_active:
		var moveDir = (papa.camera.quaternion * moveInput())
		moveDir = Vector3(moveDir.x, 0, moveDir.z).normalized()
		var smoothDir = moveDir
		var forward = papa.quaternion * Vector3.BACK
		if forward.angle_to(moveDir) >= 3.14:
			smoothDir = smoothDir.rotated(Vector3.UP, 0.1)
		else:
			smoothDir = lerp(forward, moveDir, 0.3)
		return smoothDir
	else: return Vector3.ZERO

func shouldPunch():
	return Input.is_action_just_pressed("punch") && papa.is_on_floor() && is_active
	
func shouldKick():
	return Input.is_action_just_pressed("kick") && is_active

func shouldAttack():
	return shouldPunch() || shouldKick()

func shouldJump():
	return Input.is_action_just_pressed("jump") && is_active

func shouldAct():
	return Input.is_action_just_pressed("action") && is_active
	
func moveInput() -> Vector3:
	return Vector3(
		Input.get_axis("left", "right"),
		0,
		Input.get_axis("up", "down"))
