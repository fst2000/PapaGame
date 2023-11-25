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
		return moveInput().rotated(Vector3.UP, papa.camera.rotation.y + PI).normalized()
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
		Input.get_axis("right", "left"),
		0,
		Input.get_axis("down", "up"))
