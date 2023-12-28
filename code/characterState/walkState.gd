class_name WalkState

var character
var controller
func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("Walk")
	
func update(delta : float):
	character.move(controller.moveDirection() * character.walkSpeed)
	character.lookDir(controller.moveDirection())
	if character.stepCondition:
		if character.stepCondition.check():
			character.sounds.get_node("Step").play()
	
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
	
	if controller.shouldDodge():
		return DodgeState.new(character)
	
	if !controller.shouldMove():
		if controller.shouldFight():
			return IdleFightState.new(character)
		return IdleState.new(character)
		
	if controller.shouldJump():
		return JumpState.new(character)
		
	return self
