var _character
var _controller
func _init(character):
	_character = character
	_controller = character.getController()
	character.animPlayer().play("Fall")
	
func update(delta : float):
	var moveSpeed = 4
	_character.move(_controller.moveDirection() * moveSpeed)
	#print("falling")
	
func nextState():
	if _character.isOnFloor():
		return load("res://landState.gd").new(_character)
	else: return self
