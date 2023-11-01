var _character
var _input

func _init(character):
	_character = character
	_input = character.getInput()
	character.animPlayer().play("Land")
	character.getSounds().get_node("land").play()
func update(delta : float):
	var moveSpeed = 1
	_character.move(_input.moveInput() * moveSpeed)
	#print("landing")
	
func nextState():
	if _character.animPlayer().is_playing():
		return self
	return load("res://idleState.gd").new(_character)
