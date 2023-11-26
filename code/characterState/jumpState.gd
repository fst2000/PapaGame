class_name JumpState

var character
var animPlayer
var controller

func _init(character):
	self.character = character
	self.controller = character.controller
	self.animPlayer = character.animPlayer
	self.animPlayer.play("Jump")
	character.jump()
	character.sounds.get_node("Jump").play()
	
func update(delta : float):
	pass
	
func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)

	if !animPlayer.is_playing():
		return FallState.new(character)
	else: return self
