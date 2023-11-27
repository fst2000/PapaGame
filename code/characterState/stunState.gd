class_name StunState

var character
var dir
func _init(character):
	self.character = character
	character.fightSystem.reset()
	character.animPlayer.stop()
	character.animPlayer.play("Stun")
	character.status.hasDamaged = false
	character.velocity += character.status.hitVelocity
	
func update(delta):
	pass

func nextState():
	if character.status.hp <= 0:
		return FlyoffState.new(character)
		
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)
		
	if !character.animPlayer.is_playing():
		return IdleState.new(character)
		
	return self
