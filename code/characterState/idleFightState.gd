class_name IdleFightState

var character
var controller
var timer = 0.0
func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("IdleFight")
	character.move(Vector3.ZERO)
func update(delta : float):
	timer += delta
	
func nextState():
	if character.status.hasDamaged:
		character.fightSystem.reset()
		return StunState.new(character)
		
	if !character.is_on_floor():
		character.fightSystem.reset()
		return FallState.new(character)
	
	if timer >= 0.5:
		character.fightSystem.reset()
		return IdleState.new(character)
	
	if character.controller.shouldAttack():
		return AttackState.new(character)
		
	if character.controller.shouldMove():
		character.fightSystem.reset()
		return WalkState.new(character)
		
	if character.controller.shouldJump():
		character.fightSystem.reset()
		return JumpState.new(character)
	else: return self
