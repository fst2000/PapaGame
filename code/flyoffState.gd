class_name FlyoffState

var character
var time = 0.0
var inertion
func _init(character):
	self.character = character
	character.animPlayer.stop()
	character.animPlayer.play("Flyoff")
	character.status.hasDamaged = false
	var velocity = character.status.hitVelocity
	inertion = clamp(velocity.length() * 4, 0, 5) 
	character.lookDir(-velocity)
	character.lookDir(-velocity)
	character.velocity.y = inertion
	
func update(delta):
	
	character.move(character.status.hitVelocity * inertion)
	time += delta
	inertion -= delta * 2

func nextState():
	if character.is_on_floor() && time > 0.5:
		return KOState.new(character)
	return self
