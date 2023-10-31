extends CharacterBody3D

var _velocity = Vector3.ZERO
var _gravity = -5;
var _jumpForce = 5;
var _speed = 5

func _ready():
	pass
	
func _physics_process(delta):
	var input = Vector2(
		Input.get_axis("right", "left"),
		Input.get_axis("down", "up")).normalized()
	var isJump = is_on_floor() && Input.is_action_pressed("jump")
	_velocity.x = input.x * _speed * delta * 50
	_velocity.z = input.y * _speed * delta * 50
	if is_on_floor(): _velocity.y = 0
	else: _velocity.y += _gravity * delta
	if isJump:
		_velocity.y += _jumpForce
	velocity = _velocity
	move_and_slide()
