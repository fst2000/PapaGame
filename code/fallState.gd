class_name  FallState

var character
var controller
func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("Fall")
	
func update(delta : float):
	var moveSpeed = 4
	character.move(controller.moveDirection() * moveSpeed)
	#print("falling")
	
func nextState():
	if character.is_on_floor():
		return LandState.new(character)
	else: return self
