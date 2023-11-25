class_name EnemyController

var minDistance = 1.5
var attackDistance = 2.0
var attack_time_interval = 0.8
var enemy
var navigation
var target
var attack_timer

func _init(enemy, target, navigation, attack_timer):
	self.enemy = enemy
	self.navigation = navigation
	self.target = target
	self.attack_timer = attack_timer
func set_target(target : Node3D):
	self.target = target
	
func moveDirection() -> Vector3:
	if shouldMove():
		navigation.target_position = target.global_position
		var moveVector = navigation.get_next_path_position() - enemy.global_position
		moveVector.y = 0
		var moveDirection = moveVector.normalized()
		return moveDirection
	return Vector3.ZERO

func distance():
	if target != null:
		return (enemy.global_position - target.global_position).length()
	else: return 0

func shouldJump():
	return false

func shouldAttack():
	if distance() <= attackDistance && target is Papa:
		if target.status.isAlive():
			if !attack_timer.is_active || attack_timer.time_passed() > attack_time_interval:
				attack_timer.start()
				return true
	else: return false

func shouldMove():
	if distance() > minDistance:
		if target is Papa:
			return target.status.isAlive()
		return true
	else: return false
