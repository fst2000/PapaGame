class_name FightSystem

var animPlayer : AnimationPlayer
var controller : PapaController
var hitSystem
var moveSystem
var attacks : Array[Attack]
var attackTimer : Timer = Timer.new()
var attackCount = 0

func _init(papa : Papa, attacks : Array[Attack]):
	self.animPlayer = papa.animPlayer
	self.controller = papa.controller
	self.hitSystem = papa.hitSystem
	self.attacks = attacks

func attack() -> Attack:
	var attack
	if controller.shouldAttack():
		attack = attacks[attackCount]
		if attackCount == attacks.size() - 1: attackCount = 0
		else : attackCount += 1
	return attack

func reset():
	attackCount = 0
