class_name GopnikFightSystem

var gopnik
var ground_attack
var fall_attack

func _init(gopnik, ground_attack : Attack, fall_attack : Attack):
	self.gopnik = gopnik
	self.ground_attack = ground_attack
	self.fall_attack = fall_attack

func attack() -> Attack:
	if gopnik.is_on_floor():
		return ground_attack
	return fall_attack

func reset():
	pass
