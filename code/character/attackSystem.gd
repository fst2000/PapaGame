class_name AttackSystem

var attacks : Array[Attack]
var attackTimer : Timer = Timer.new()
var attackCount = 0

func _init(attacks : Array[Attack]):
	self.attacks = attacks

func attack() -> Attack:
	var attack = attacks[attackCount]
	if attackCount == attacks.size() - 1: reset()
	else : attackCount += 1
	return attack

func reset():
	attackCount = 0
