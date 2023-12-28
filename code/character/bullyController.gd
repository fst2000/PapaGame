class_name BullyController

var is_active = true
var minDistance = 0.5
var stopDistance = 1.5
var attackDistance = 2.0
var attack_time_interval = 0.6
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
	if target:
		navigation.target_position = target.global_position
		var nav_direction = bully.global_position.direction_to(navigation.get_next_path_position())
		nav_direction.y = 0
		return lerp(bully.forward(), nav_direction, 0.1)
	return Vector3.ZERO

func attackDirection() -> Vector3:
	return moveDirection()

func distance():
	if target:
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
	if (distance() > stopDistance):
		if target is Papa:
			return target.status.isAlive()
		return true
	return false

func shouldFight():
	if target is Papa:
		return target.status.isAlive()
	return false

func shouldAct():
	return false
	
func fightCondition():
	return FuncCondition.new(func(): return shouldFight())
