class_name HooderController

var is_active = true
var minDistance = 0.5
var stopDistance = 2.5
var attackDistance = 3.5
var attack_time_interval = 1.5
var hooder
var navigation
var target
var attack_time_condition = TimeCondition.new(attack_time_interval)

func _init(hooder, target, navigation):
	self.hooder = hooder
	self.navigation = navigation
	self.target = target
func set_target(target : Node3D):
	self.target = target
	
func moveDirection() -> Vector3:
	if shouldMove():
		navigation.target_position = target.global_position
		var move_direction = hooder.global_position.direction_to(navigation.get_next_path_position())
		move_direction.y = 0
		return lerp(hooder.forward(), move_direction, 1)
	return Vector3.ZERO

func attackDirection() -> Vector3:
	return hooder.forward()

func distance():
	if target != null:
		var distance = hooder.global_position - target.global_position
		distance.y = 0
		return distance.length()
	else: return 0

func shouldJump():
	return false

func shouldAttack():
	if distance() <= attackDistance && distance() > minDistance && target is Papa:
		if target.status.isAlive():
			if hooder.status.hasDamaged:
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

func shouldFight():
	if target is Papa:
		return target.status.isAlive()
	return false

func shouldAct():
	return false

func shouldDodge(): return false

func fightCondition():
	return FuncCondition.new(func(): return shouldFight())
