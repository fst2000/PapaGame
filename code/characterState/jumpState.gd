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
	character.sounds.get_node("Jump").play()
	startVelocity = Vector3(character.velocity.x, 0, character.velocity.z)
	
func update(delta : float):
	var moveVelocity = controller.moveDirection() * character.walkSpeed
	var fallVelocity = startVelocity + moveVelocity
	if fallVelocity.length() > startVelocity.length():
		fallVelocity = fallVelocity.normalized() * max(startVelocity.length(), moveVelocity.length())
	character.move(fallVelocity)
	character.lookDir(lerp(character.forward(), fallVelocity, delta * 10))
	
func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)

	if !animPlayer.is_playing():
		return FallState.new(character)
	else: return self
