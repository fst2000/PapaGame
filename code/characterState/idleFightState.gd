class_name IdleFightState

var character
var controller
var time_condition = TimeCondition.new(2)

func _init(character):
	self.character = character
	self.controller = character.controller
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
	
	if character.controller.shouldAttack():
		return AttackState.new(character)
		
	if character.controller.shouldMove():
		return WalkState.new(character)
		
	if character.controller.shouldJump():
		return JumpState.new(character)
	
	if !time_condition.check():
		return IdleState.new(character)
		
	return self
