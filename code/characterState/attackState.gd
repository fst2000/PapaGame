class_name AttackState

var character
var attack : Attack
var timePassed = 0.0
var startVelocity
var starts_in_air
func _init(character):
	self.character = character
	attack = character.fightSystem.attack()
	character.animPlayer.play(attack.animName)
	character.sounds.get_node("AirWave").play()
	startVelocity = character.velocity
	starts_in_air = !character.is_on_floor()
	character.status.hasHit = false

func update(delta):
	timePassed += delta
	if timePassed >= attack.startHitTime && timePassed <= attack.endHitTime:
		attack.hitSystem.hit(attack)
	var move_vector = character.quaternion * attack.move_velocity
	if character.is_on_floor():
		character.move(move_vector)
	character.lookDir(character.controller.attackDirection())

func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)
	
	if character.is_on_floor() && character.controller.shouldJump():
		return JumpState.new(character)
	
	if !character.animPlayer.is_playing():
		if character.is_on_floor():
			return IdleFightState.new(character)
		else:
			return FallState.new(character)
			
	if starts_in_air && character.is_on_floor():
		return LandState.new(character)
		
	return self
