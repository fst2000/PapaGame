class_name SlideState

var character
var slide_sound
func _init(character):
	self.character = character
	character.animPlayer.play("Slide")
	slide_sound = character.sounds.get_node("Slide")
	slide_sound.play()
	
func update(delta : float):
	var normal = character.get_floor_normal()
	var slide_inertion = 5.0
	var max_velocity = 10
	var slope_direction = Vector3(normal.x, 0, normal.z).normalized()
	var slope_direction_rotated = slope_direction.rotated(Vector3.UP.cross(normal).normalized(), Vector3.UP.angle_to(normal))
	character.velocity += slope_direction_rotated * slide_inertion * delta
	if character.velocity.length() > max_velocity:
		character.velocity = character.velocity.normalized() * max_velocity
	var look_direction = lerp(character.forward(), character.velocity, delta * 10)
	character.look_at(character.global_position - look_direction)
	
	var sound_db = log(character.velocity.length()) - max_velocity
	slide_sound.set_volume_db(sound_db)
	
func nextState():
	if character.status.hasDamaged:
		exit()
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)

	if !character.is_on_floor():
		exit()
		return FallState.new(character)

	if character.controller.shouldJump():
		exit()
		return JumpState.new(character)
	
	if !character.status.slide:
		exit()
		return IdleState.new(character)
	
	return self

func exit():
	character.lookDir(character.forward())
	slide_sound.stop()
