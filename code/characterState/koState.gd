class_name KOState

var character
func _init(character):
	self.character = character
	character.animPlayer.play("KO")
	character.sounds.get_node("Land").play()
	character.set_collision_layer_value(2, false)
	character.set_collision_mask_value(2,false)
	character.move(Vector3.ZERO)
	
func update(delta):
	pass
func nextState():
	return self
