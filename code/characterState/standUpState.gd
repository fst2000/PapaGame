class_name StandUpState

var character

func _init(character):
	self.character = character
	character.animPlayer.play("StandUp")
	character.move(Vector3.ZERO)

func update(delta):
	pass

func nextState():
	if character.status.hasDamaged:
		if character.status.flyoff:
			return FlyoffState.new(character)
		return StunState.new(character)

	if !character.is_on_floor():
		return FallState.new(character)
	if !character.animPlayer.is_playing():
		return IdleState.new(character)
	return self
