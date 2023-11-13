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
	#character.sounds.get_node("Attack").play()
func update(delta):
	timePassed += delta
	if timePassed >= attack.hitTime && !hasHit:
		character.hitSystem.hit(attack.damage)
		hasHit = true
	var inertion = clamp(character.animPlayer.current_animation_length - timePassed, 0, 1)
	var moveDir
	if character.controller.moveDirection().length() > 0:
		moveDir = character.controller.moveDirection()
	else: moveDir = character.forward()
	character.move(moveDir * inertion * 5)
	character.lookDir(character.controller.moveDirection())

func nextState():
	if character.status.hasDamaged:
		character.fightSystem.reset()
		return StunState.new(character)

	if !character.animPlayer.is_playing():
		if character.is_on_floor():
			return IdleFightState.new(character)
		else:
			character.fightSystem.reset()
			return FallState.new(character)
	else: return self
