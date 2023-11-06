class_name PunchState

var _character
var _controller
var _animPlayer : AnimationPlayer
var _hasPunched
var _hasHit = false
var _rotation
var _impulse = 1.0
var _number
var _comboLength
var _time  = 0.0
func _init(character, number : int, comboLength : int):
	_character = character
	_number = number
	_comboLength = comboLength
	_animPlayer = character.animPlayer()
	_controller = character.getController()
	_animPlayer.play("Punch" + str(number))
	_character._sounds.get_node("AirWave").play()
	
func update(delta : float):
	_impulse -= delta * 2
	if _impulse > 0 :
		if _controller.isMoving():
			_character.move(_controller.moveDirection() * _impulse)
		else: 
			_character.move(Vector3.BACK.rotated(Vector3.UP, _character.rotation.y) * _impulse)
	_time += delta
	if _time > 0.2 && !_hasHit:
		_character.hit()
		_hasHit = true
	if _controller.isPunching() && _hasHit:
		_hasPunched = true
	
func nextState():
	if !_character.is_on_floor():
		return FallState.new(_character)
	if !_animPlayer.is_playing():
		if _hasPunched && _number != _comboLength:
			return PunchState.new(_character, _number + 1, _comboLength)
		else: return IdleState.new(_character)
	else: return self
