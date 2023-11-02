extends CharacterBody3D

var moveSpeed = 2.0
var _minDistance = 1.5
@export var _playerPath : String

@onready var _player : Node3D = get_tree().get_root().get_node(_playerPath)
@onready var nav =  $NavigationAgent3D
func _physics_process(delta):
	nav.target_position = _player.global_position
	var moveVector = nav.get_next_path_position() - global_position
	var distance = (global_position - _player.global_position).length()
	if distance > _minDistance:
		print(moveVector.length())
		var moveVelocity = moveVector.normalized() * moveSpeed
		velocity = moveVelocity
	else : velocity = Vector3.ZERO
	move_and_slide()
