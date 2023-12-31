class_name IdleFightState

var character
var controller
var condition

func _init(character):
	self.character = character
	self.controller = character.controller
	condition = controller.fightCondition()
	character.animPlayer.play("IdleFight")
	character.move(Vector3.ZERO)
	
func update(delta : float):
	pass
	
func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)
		
	if !character.is_on_floor():
		return FallState.new(character)
	
	if character.status.slide:
		return SlideState.new(character)
	
	if character.controller.shouldAttack():
		return AttackState.new(character)
		
	if character.controller.shouldMove():
		return WalkState.new(character)
	
	if controller.shouldDodge():
		return DodgeState.new(character)
	
	if character.controller.shouldJump():
		return JumpState.new(character)
		
	if !condition.check():
		return IdleState.new(character)
		
	return self
