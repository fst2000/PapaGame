class_name BullyFightSystem

var bully
var punchSystem
var kickSystem

func _init(bully, punchSystem : AttackSystem, kickSystem : AttackSystem):
	self.bully = bully
	self.punchSystem = punchSystem
	self.kickSystem = kickSystem
	
func attack() -> Attack:
	var controller = bully.controller
	var attack
	if controller.shouldPunch():
		attack = punchSystem.attack()
		
	if controller.shouldKick():
		attack = kickSystem.attack()
	return attack

func reset():
	punchSystem.reset()
	kickSystem.reset()
