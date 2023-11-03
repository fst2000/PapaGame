extends CharacterBody3D

@export var _camera: Camera3D
@export var _controllerRes : Resource
@export var _animPlayerPath : String
@export var _moveInertion = 0.1

const _gravity = -10;
const _jumpForce = 5;
var _hasMoved = false
@onready var _animPlayer : AnimationPlayer = get_node(_animPlayerPath)
@onready var _state = load("res://idleState.gd").new(self)
@onready var _controller = _controllerRes.new(self)
@onready var _sounds = $Sounds
func getCamRotation():
	return _camera.rotation

func getController():
	return _controller

func getSounds() -> Node:
	return _sounds

func isOnFloor():
	return is_on_floor()

func animPlayer():
	return _animPlayer

func _process(delta):
	_state = _state.nextState()
	_state.update(delta)
	
	if is_on_floor() && !_controller.isJumping(): velocity.y = 0;
	else: velocity.y += _gravity * delta
	if _hasMoved:
		move_and_slide()
		_hasMoved = false

func move(v: Vector3):
	velocity.x = v.x
	velocity.z = v.z
	if v.length() != 0:
		look_at(position - v)
	_hasMoved = true	
func jump():
	velocity.y += _jumpForce
