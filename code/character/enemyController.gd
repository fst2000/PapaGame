class_name EnemyController

var minDistance = 1.2
var attackDistance = 1.5
var enemy
var navigation
var target

func _init(enemy, target, navigation):
	self.enemy = enemy
	self.navigation = navigation
	self.target = target
	
func set_target(target : Node3D):
	self.target = target
	
func moveDirection() -> Vector3:
	if target != null:
		navigation.target_position = target.global_position
		var moveVector = navigation.get_next_path_position() - enemy.global_position
		moveVector.y = 0
		var moveDirection = moveVector.normalized()
		if distance() > minDistance:
			return moveDirection
	return Vector3.ZERO

func distance():
	if target != null:
		return (enemy.global_position - target.global_position).length()
	else: return 0

func shouldJump():
	return false

func shouldPunch():
	return distance() <= attackDistance && target is Papa

func shouldKick():
	return false

func shouldAttack():
	return shouldPunch() || shouldKick()

func shouldMove():
	return moveDirection().length() > 0.1
