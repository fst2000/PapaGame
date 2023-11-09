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
	var moveSpeed = 4
	character.move(controller.moveDirection() * moveSpeed)
	character.lookDir(controller.moveDirection())
	
func nextState():
	if character.status.hasDamaged:
		return StunState.new(character)
	if !animPlayer.is_playing():
		return FallState.new(character)
	else: return self
