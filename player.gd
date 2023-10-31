extends CharacterBody3D

@export var _camera: Camera3D
var moveVelocity = Vector3.ZERO
var fallVelocity = Vector3.ZERO
var _lerpInput = Vector3.ZERO
var _gravity = -10;
var _jumpForce = 6;
var _speed = 4
var state = load("res://idleState.gd").new(self)
func _ready():
	pass

func _process(delta):
	state = state.nextState()
	state.update(delta)
func _physics_process(delta):
	var isJump = is_on_floor() && Input.is_action_pressed("jump")
	
	var input = Vector3(
		Input.get_axis("right", "left"),
		0,
		Input.get_axis("down", "up")).normalized()
	_lerpInput = lerp(_lerpInput, input, 0.1)
	
	var lookRotation = _camera.rotation.y + PI
	moveVelocity = _lerpInput.rotated(Vector3.UP, lookRotation) * _speed * delta * 50
	
	if is_on_floor(): fallVelocity.y = 0
	else: fallVelocity.y += _gravity * delta
	
	if isJump:
		fallVelocity.y += _jumpForce
		
	if moveVelocity.length() > 0.1:
		var playerRotation = position - moveVelocity
		look_at(playerRotation)
	
	velocity = moveVelocity + fallVelocity
	move_and_slide()
