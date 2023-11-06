class_name EnemyController

extends NavigationAgent3D
var _minDistance = 1.5
var _body
@export var _target : Node3D

func _init(character):
	_body = character

func moveDirection() -> Vector3:
	target_position = _target.global_position
	var moveVector = get_next_path_position() - _body.global_position
	var distance = (_body.global_position - _target.global_position).length()
	var moveDirection = moveVector.normalized()
	if distance > _minDistance:
		return moveDirection
	return Vector3.ZERO
	
func isJumping(): return false

func isPunching(): return false

func isKicking(): return false

func isMoving():
	return Vector2(velocity.x, velocity.z).length() > 0.1
