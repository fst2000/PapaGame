class_name  LandState

var character
var controller
var inertion = 8.0
func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("Land")
	character.sounds.get_node("Land").play()
	
func update(delta : float):
	var moveSpeed = 1
	character.velocity = lerp(character.velocity, Vector3.ZERO, inertion * delta)
	
func nextState():
	if character.status.slide:
		return SlideState.new(character)
		
	if character.status.hasDamaged:
		return StunState.new(character)
	
	if controller.shouldDodge():
		return DodgeState.new(character)
	
	if !character.animPlayer.is_playing():
		if controller.shouldFight():
			return IdleFightState.new(character)
		return IdleState.new(character)
	
	return self
