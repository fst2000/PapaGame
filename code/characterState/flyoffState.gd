class_name FlyoffState

var character
var min_time = 0.2
var time_passed = 0.0

func _init(character):
	self.character = character
	character.fightSystem.reset()
	character.animPlayer.stop()
	character.animPlayer.play("Flyoff")
	character.status.hasDamaged = false
	character.status.flyoff = false
	var hit_velocity = character.status.hitVelocity
	character.lookDir(-hit_velocity)
	character.velocity += hit_velocity
	
func update(delta : float):
	time_passed += delta
	
func nextState():
	if character.is_on_floor():
		character.sounds.get_node("Land").play()
		if time_passed > min_time:
			if character.status.hp <= 0:
				return KOState.new(character)
			return StandUpState.new(character)
	return self
