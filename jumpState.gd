var _character
var _animPlayer
var _input

func _init(character):
	_character = character
	_input = character.getInput()
	_animPlayer = character.animPlayer()
	_animPlayer.play("Jump")
	character.jump()
	character.getSounds().get_node("jump").play()
	
func update(delta : float):
	var moveSpeed = 4
	_character.move(_input.moveInput() * moveSpeed)
	#print("jumping")
	
func nextState():
	if !_animPlayer.is_playing():
		return load("res://fallState.gd").new(_character)
	else: return self
