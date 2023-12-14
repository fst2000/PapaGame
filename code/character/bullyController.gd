class_name BullyController

var is_active = true
var minDistance = 0.5
var stopDistance = 1.5
var attackDistance = 2.0
var attack_time_interval = 1.8
var bully
var navigation
var target
var attack_time_condition = TimeCondition.new(attack_time_interval)

func _init(bully, target, navigation):
	self.bully = bully
	self.navigation = navigation
	self.target = target
func set_target(target : Node3D):
	self.target = target
	
func moveDirection() -> Vector3:
	if shouldMove():
		navigation.target_position = target.global_position
		var moveDirection = bully.global_position.direction_to(navigation.get_next_path_position())
		moveDirection.y = 0
		return moveDirection
	return Vector3.ZERO

func attackDirection() -> Vector3:
	return bully.forward()

func distance():
	if target != null:
		return (bully.global_position - target.global_position).length()
	else: return 0

func shouldJump():
	return false

func shouldAttack():
	if distance() <= attackDistance && distance() > minDistance && target is Papa:
		if target.status.isAlive():
			if bully.status.hasDamaged:
				attack_time_condition = TimeCondition.new(attack_time_interval)
			if !attack_time_condition.check():
				attack_time_condition = TimeCondition.new(attack_time_interval)
				return true
	return false

func shouldMove():
	if distance() > stopDistance:
		if target is Papa:
			return target.status.isAlive()
		return true
	else: return false
