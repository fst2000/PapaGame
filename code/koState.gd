class_name KOState

var character
func _init(character):
	self.character = character
	character.animPlayer.play("KO")
func update(delta):
	pass
func nextState():
	return self
