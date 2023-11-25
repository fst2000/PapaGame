class_name  LandState

var character
var controller

func _init(character):
	self.character = character
	self.controller = character.controller
	character.move(Vector3.ZERO)
	character.animPlayer.play("Land")
	character.sounds.get_node("Land").play()
	
func update(delta : float):
	var moveSpeed = 1
	character.move(controller.moveDirection() * moveSpeed)
	#print("landing")
	
func nextState():
	if character.status.hasDamaged:
		return StunState.new(character)
	if character.animPlayer.is_playing():
		return self
	return IdleState.new(character)
