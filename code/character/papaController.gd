class_name PapaController

var papa
var is_active = true;
var move_input = Vector3.ZERO

func _init(papa):
	self.papa = papa

func shouldFight():
	return false

func shouldMove():
	return moveInput().length() > 0.1 && is_active
	
func moveDirection() -> Vector3:
	var direction = move_input.rotated(Vector3.UP, papa.camera.rotation.y + PI).normalized()
	#ar lerpDirection = lerp(papa.forward(), direction, 0.3)
	#return lerpDirection
	return direction

func attackDirection() -> Vector3:
	var dir = moveDirection()
	if dir.length() > 0.1:
		return moveDirection()
	if papa.target:
		var direction = papa.target.global_position - papa.global_position
		direction.y = 0
		return direction.normalized()
	return papa.forward()

func shouldPunch():
	return Input.is_action_just_pressed("punch") && papa.is_on_floor() && is_active
	
func shouldKick():
	return Input.is_action_just_pressed("kick") && is_active

func shouldAttack():
	return shouldPunch() || shouldKick()

func shouldJump():
	return Input.is_action_just_pressed("jump") && is_active

func shouldAct():
	return is_active
	
func moveInput() -> Vector3:
	return Vector3(
		Input.get_axis("right", "left"),
		0,
		Input.get_axis("down", "up"))

func update(delta):
	move_input = lerp(move_input, moveInput(), delta * 20)
	if !shouldMove():
		move_input = Vector3.ZERO
