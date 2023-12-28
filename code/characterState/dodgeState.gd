class_name DodgeState

var character

func _init(character):
	self.character = character
	character.animPlayer.play("Dodge")
	character.dodge()

func update(delta):
	var inertion = 2
	character.velocity = lerp(character.velocity, Vector3.ZERO, inertion * delta)
	
func nextState():
	if !character.animPlayer.is_playing():
		character.undodge()
		return IdleFightState.new(character)
	
	if character.controller.shouldAttack():
		return AttackState.new(character)
	
	if character.controller.shouldJump():
		character.undodge()
		return JumpState.new(character)
	
	if character.status.hasDamaged:
		character.undodge()
		return StunState.new(character)
	return self
