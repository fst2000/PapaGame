class_name  FallState

var character
var controller
var startVelocity
var inertion = 2.0

func _init(character):
	self.character = character
	self.controller = character.controller
	character.animPlayer.play("Fall")
	startVelocity = Vector3(character.velocity.x, 0, character.velocity.z)

func update(delta : float):
	var moveVelocity = startVelocity + controller.moveDirection()
	character.lookDir(moveVelocity)
	character.move(moveVelocity)

func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)
		
	if character.is_on_floor():
		if character.status.slide:
			return SlideState.new(character)
		return LandState.new(character)
		
	if character.controller.shouldAttack():
		return AttackState.new(character)
	else: return self
