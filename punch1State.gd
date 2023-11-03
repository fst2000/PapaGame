var _character
var _controller
var _animPlayer
var _hasPunched
var _rotation
var _impulse = 1.0

func _init(character):
	_character = character
	_animPlayer = character.animPlayer()
	_controller = character.getController()
	_animPlayer.play("Punch1")
	_character._sounds.get_node("airWave").play()
	_rotation = Vector3.BACK.rotated(Vector3.UP, _character.rotation.y)
	
func update(delta : float):
	_impulse -= delta * 2
	if _impulse > 0 :
		_character.move(_rotation * _impulse)
	
func nextState():
	if !_character.is_on_floor():
		return load("res://fallState.gd").new(_character)
	if !_animPlayer.is_playing():
		return load("res://idleState.gd").new(_character)
	return self
