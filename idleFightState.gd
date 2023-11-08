class_name IdleFightState

var character
var controller

func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("IdleFight")
	
func update(delta : float):
	pass
	
func nextState():
	if character.controller.shouldAttack():
		return AttackState.new(character)
	if character.controller.shouldMove():
		return WalkState.new(character)
	else: return self
