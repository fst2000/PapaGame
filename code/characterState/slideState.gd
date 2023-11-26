class_name SlideState

var character

func _init(character):
	self.character = character
	character.animPlayer.play("Slide")
	
func update(delta : float):
	var normal = character.get_floor_normal()
	var slide_inertion = 15.0
	var max_velocity = 10
	var slope_direction = Vector3(normal.x, 0, normal.z).rotated((Vector3.UP * normal).normalized(), Vector3.UP.angle_to(normal)).normalized()
	var move_direction = character.controller.moveDirection()
	move_direction = move_direction.rotated((normal * slope_direction).normalized(), Vector3.UP.angle_to(normal))
	var slide_direction = lerp(slope_direction, move_direction, 0.4)
	character.lookDir(character.velocity)
	character.velocity += slide_direction * slide_inertion * delta
	if character.velocity.length() > max_velocity:
		character.velocity = character.velocity.normalized() * max_velocity
	
	
func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)

	if !character.is_on_floor():
		return FallState.new(character)

	if character.controller.shouldJump():
		return JumpState.new(character)
	
	if !character.status.slide:
		return IdleState.new(character)
	
	return self
