class_name OutSnowcatState

var character

func _init(character):
	self.character = character
	character.reparent(character.get_node("/root"))
	character.animPlayer.play("Snowcat_Out")

func update(delta):
	pass

func nextState():
	if !character.animPlayer.is_playing():
		return IdleState.new(character)
	return self
