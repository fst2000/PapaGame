class_name JumpState

var character
var animPlayer
var controller
var startVelocity

func _init(character):
	self.character = character
	self.controller = character.controller
	self.animPlayer = character.animPlayer
	self.animPlayer.play("Jump")
	character.jump()
	startVelocity = Vector3(character.velocity.x, 0, character.velocity.z)
	
func update(delta : float):
	var moveVelocity = controller.moveDirection() * character.jumpSpeed
	var fallVelocity = startVelocity * 0.5 + moveVelocity 
	character.move(fallVelocity)
	character.lookDir(lerp(character.forward(), fallVelocity, delta * 10))
	
func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)
	
	if controller.shouldAttack():
		return AttackState.new(character)
	
	if !animPlayer.is_playing():
		return FallState.new(character)
	else: return self
