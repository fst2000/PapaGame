var _character

func _init(character):
	_character = character
	character.animPlayer().play("Land")
func update(delta : float):
	print("landing")
	
func nextState():
	if _character.animPlayer().is_playing():
		return self
	return load("res://idleState.gd").new(_character)
