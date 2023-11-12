class_name KOState

var character
func _init(character):
	self.character = character
	character.animPlayer.play("KO")
	character.sounds.get_node("Land").play()
	#character.sounds.get_node("KO").play()
	character.set_collision_layer_value(2, false)
	
func update(delta):
	pass
func nextState():
	return self
