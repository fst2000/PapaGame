class_name  LandState

var _character
var _controller

func _init(character):
	_character = character
	_controller = character.getController()
	character.animPlayer().play("Land")
	character.getSounds().get_node("Land").play()
func update(delta : float):
	var moveSpeed = 1
	_character.move(_controller.moveDirection() * moveSpeed)
	#print("landing")
	
func nextState():
	if _character.animPlayer().is_playing():
		return self
	return IdleState.new(_character)
