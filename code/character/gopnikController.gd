class_name GopnikController

var is_active = true
var minDistance = 0.5
var stopDistance = 1.5
var attackDistance = 2.0
var attack_time_interval = 0.7
var jump_time_interval = 2.5

var delta = 0.0

var gopnik
var navigation
var target
var attack_time_condition = TimeCondition.new(attack_time_interval)
var jump_time_condition = TimeCondition.new(jump_time_interval)

func _init(gopnik, target, navigation):
	self.gopnik = gopnik
	self.navigation = navigation
	self.target = target
func set_target(target : Node3D):
	self.target = target
	
func moveDirection() -> Vector3:
	if target:
		navigation.target_position = target.global_position
		var move_direction = gopnik.global_position.direction_to(navigation.get_next_path_position())
		move_direction.y = 0
		return lerp(gopnik.forward(), move_direction, 5 * delta)
	return Vector3.ZERO

func attackDirection() -> Vector3:
	return moveDirection()

func distance():
	if target:
		var dist = gopnik.global_position - target.global_position
		dist.y = 0
		return dist.length()
	else: return 0

func shouldJump():
	if shouldFight() && !gopnik.state is AttackState:
		if gopnik.status.hasDamaged:
			jump_time_condition = TimeCondition.new(jump_time_interval)
		if !jump_time_condition.check():
			jump_time_condition = TimeCondition.new(jump_time_interval)
			return true
	return false

func shouldFight():
	if target is Papa:
		return target.status.isAlive()
	return false

func shouldAttack():
	if distance() <= attackDistance && distance() > minDistance && target is Papa:
		if target.status.isAlive():
			if gopnik.status.hasDamaged:
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

func shouldAct():
	return false
	
func update(delta):
	self.delta = delta

func shouldDodge(): return false

func fightCondition():
	return FuncCondition.new(func(): return shouldFight())
