class_name PapaFightSystem

var papa : Papa
var punchSystem
var kickSystem
var fallKickSystem
var dodgePunch

func _init(
	papa : Papa,
	punchSystem : AttackSystem,
	kickSystem : AttackSystem,
	fallKickSystem : AttackSystem,
	dodgePunch : Attack):

	self.papa = papa
	self.punchSystem = punchSystem
	self.kickSystem = kickSystem
	self.fallKickSystem = fallKickSystem
	self.dodgePunch = dodgePunch
	
func attack() -> Attack:
	var controller = papa.controller
	var attack
	if controller.shouldPunch():
		if papa.state is DodgeState:
			attack = dodgePunch
		else: attack = punchSystem.attack()
		
	if controller.shouldKick():
		if papa.is_on_floor():
			attack = kickSystem.attack()
		else:
			attack = fallKickSystem.attack()
	return attack

func reset():
	punchSystem.reset()
	kickSystem.reset()
	fallKickSystem.reset()
