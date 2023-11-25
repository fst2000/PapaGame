class_name AttackState

var character
var attack : Attack
var timePassed = 0.0
var hasHit = false
func _init(character):
	self.character = character
	attack = character.fightSystem.attack()
	character.animPlayer.play(attack.animName)
	character.sounds.get_node("AirWave").play()
func update(delta):
	timePassed += delta
	if timePassed >= attack.hitTime && !hasHit:
		character.hitSystem.hit(attack)
		hasHit = true

	var inertion = clamp(character.animPlayer.current_animation_length - timePassed, 0, 1)
	character.move(character.forward() * inertion * 5)
	if character.target != null:
		character.lookDir(character.global_position.direction_to(character.target.global_position))
	else:
		character.lookDir(character.controller.moveDirection())

func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)
		
	if !character.animPlayer.is_playing():
		if character.is_on_floor():
			return IdleFightState.new(character)
		else:
			return FallState.new(character)
	else: return self
