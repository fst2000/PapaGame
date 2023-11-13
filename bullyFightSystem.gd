class_name BullyFightSystem

var papa : Papa
var punchSystem
var kickSystem

func _init(papa : Papa, punchSystem : AttackSystem, kickSystem : AttackSystem):
	self.papa = papa
	self.punchSystem = punchSystem
	self.kickSystem = kickSystem
	
func attack() -> Attack:
	var controller = papa.controller
	var attack
	if controller.shouldPunch():
		attack = punchSystem.attack()
		
	if controller.shouldKick():
		attack = kickSystem.attack()
	return attack

func reset():
	punchSystem.reset()
	kickSystem.reset()
