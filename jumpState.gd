var _character
var _animPlayer
func _init(character):
	_character = character
	_animPlayer = character.animPlayer()
	_animPlayer.play("Jump")
	character.jump()
func update(delta : float):
	_character.move(_character._input.moveInput())
	print("jumping")
	
func nextState():
	if !_animPlayer.is_playing():
		return load("res://fallState.gd").new(_character)
	else: return self
