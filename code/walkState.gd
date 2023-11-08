class_name WalkState

var character
var controller
func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("Walk")
	
func update(delta : float):
	var moveSpeed = 4
	character.move(controller.moveDirection() * moveSpeed)
	#print("walk")
	
func nextState():
	if !character.is_on_floor():
		return FallState.new(character)
	if character.controller.shouldAttack():
		return AttackState.new(character)
	if !controller.shouldMove():
		return IdleState.new(character)
	if controller.shouldJump():
		return JumpState.new(character)
	return self
