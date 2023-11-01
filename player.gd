extends CharacterBody3D

@export var _camera: Camera3D
@export var _animatorPath: String
const _gravity = -10;
const _jumpForce = 6;
const _speed = 4
var _hasMoved = false
@onready var _animPlayer : AnimationPlayer = get_node(_animatorPath)
@onready var _state = load("res://idleState.gd").new(self)
@onready var _input = load("res://playerInput.gd").new(self)

func getCamRotation():
	return _camera.rotation

func getInput():
	return _input

func isOnFloor():
	return is_on_floor()

func animPlayer():
	return _animPlayer

func jumpForce():
	return _jumpForce
	
func _process(delta):
	_state = _state.nextState()
	_state.update(delta)
	
	if is_on_floor() && !_input.isJumping(): velocity.y = 0;
	else: velocity.y += _gravity * delta
	if _hasMoved:
		move_and_slide()
		_hasMoved = false

func move(v: Vector3):
	v = v.normalized()
	velocity.x = lerp(velocity.x, v.x * _speed, 0.1)
	velocity.z = lerp(velocity.z, v.z * _speed, 0.1)
	var lookDir = Vector3(velocity.x, 0, velocity.z)
	if lookDir.length() != 0:
		look_at(position - lookDir)
	_hasMoved = true
	print(velocity)
	
func jump():
	velocity.y += _jumpForce
