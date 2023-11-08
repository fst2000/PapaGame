class_name IdleState

var character
var controller

func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("Idle")
	
func update(delta : float):
	pass
	
func nextState():
	if !character.is_on_floor():
		return FallState.new(character)
	if controller.shouldAttack():
		return AttackState.new(character)
	if controller.shouldMove():
		return WalkState.new(character)
	if controller.shouldJump():
		return JumpState.new(character)
	return self
