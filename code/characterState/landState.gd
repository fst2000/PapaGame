class_name  LandState

var character
var controller
var inretion = 4.0
func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("Land")
	character.sounds.get_node("Land").play()
	
func update(delta : float):
	var moveSpeed = 1
	character.velocity = lerp(character.velocity, Vector3.ZERO, inretion * delta)
	
func nextState():
	if character.status.slide:
		return SlideState.new(character)
		
	if character.status.hasDamaged:
		return StunState.new(character)
		
	if character.animPlayer.is_playing():
		return self
		
	return IdleState.new(character)
