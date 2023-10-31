extends CharacterBody3D

@export var _camera: Camera3D
var moveVelocity = Vector3.ZERO
var fallVelocity = Vector3.ZERO
var _gravity = -10;
var _jumpForce = 6;
var _speed = 5
var isWalking = false
var isFalling = false

func _ready():
	pass

#func _process(delta):
#	if is_on_floor():
#		if moveVelocity.length() > 0.1:
#			if !isWalking: _animator.play("Walk")
#			isWalking = true
#	else:
#		if !isFalling: _animator.play("Fall")
	
func _physics_process(delta):
	var input = Vector2(
		Input.get_axis("right", "left"),
		Input.get_axis("down", "up")).normalized()
	var isJump = is_on_floor() && Input.is_action_pressed("jump")
	var lookRotation = _camera.rotation.y + PI
	moveVelocity = Vector3(input.x, 0, input.y) * _speed * delta * 50
	if is_on_floor(): fallVelocity.y = 0
	else: fallVelocity.y += _gravity * delta
	if isJump:
		fallVelocity.y += _jumpForce
		
	moveVelocity = moveVelocity.rotated(Vector3.UP, lookRotation)
	if moveVelocity.length() > 0.01:
		var playerRotation = position - moveVelocity
		look_at(playerRotation)
	velocity = moveVelocity + fallVelocity
	move_and_slide()
