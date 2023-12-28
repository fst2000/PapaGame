class_name KOState

var character
func _init(character):
	self.character = character
	character.animPlayer.play("KO")
	character.sounds.get_node("Land").play()
	character.move(Vector3.ZERO)
	character.set_active(false)
	if character.koAction:
		character.koAction.call()

func update(delta):
	character.move(Vector3.ZERO)
func nextState():
	return self
