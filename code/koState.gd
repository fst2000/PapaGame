class_name KOState

var character
var inertion : float
func _init(character):
	self.character = character
	character.animPlayer.play("KO")
	var velocity = character.status.hitVelocity
	inertion = clamp(velocity.length() * 2, 0, 5) 
	character.lookDir(-velocity)
func update(delta):
	if inertion > 0:
		character.move(character.status.hitVelocity * inertion)
	inertion -= delta * 2
func nextState():
	return self
