class_name StunState

var character
var dir
func _init(character):
	self.character = character
	character.animPlayer.stop()
	character.animPlayer.play("Stun")
	character.status.hasDamaged = false
	dir = character.status.hitVelocity
	character.lookDir(-dir)
	
	
func update(delta):
	character.move(dir)

func nextState():
	if character.status.hp <= 0:
		return FlyoffState.new(character)
		
	if character.status.hasDamaged:
		return StunState.new(character)
		
	if !character.animPlayer.is_playing():
		return IdleState.new(character)
		
	return self
