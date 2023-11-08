class_name EnemyController

extends NavigationAgent3D

@export var target : Node3D
var minDistance = 1.5
var character

func _init(character):
	self.character = character

func moveDirection() -> Vector3:
	target_position = target.global_position
	var moveVector = get_next_path_position() - character.global_position
	var distance = (character.global_position - target.global_position).length()
	var moveDirection = moveVector.normalized()
	if distance > minDistance:
		return moveDirection
	return Vector3.ZERO
	
func shouldJump():
	return false

func shouldPunch():
	return false

func shouldKick():
	return false

func shouldMove():
	return moveDirection().length() > 0.1
