class_name AttackState

var character
var attack : Attack
var timePassed = 0.0
var hasHit = false
func _init(character):
	self.character = character
	attack = character.fightSystem.attack()
	character.animPlayer.play(attack.animName)
	
func update(delta):
	timePassed += delta
	if timePassed >= attack.hitTime && !hasHit:
		character.hitSystem.hit(attack.damage)
		hasHit = true
	
	var inertion = clamp(attack.endTime - timePassed, 0, 1)
	character.move(character.forward() * inertion * 4)

func nextState():
	if timePassed >= attack.endTime:
		if character.controller.shouldAttack(): return AttackState.new(character)
		else:
			character.fightSystem.reset()
			return IdleFightState.new(character)
	else: return self
