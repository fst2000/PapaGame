class_name OutSnowcatState

var character

func _init(character):
	self.character = character
	character.reparent(character.get_node("/root"))
	character.animPlayer.play("Snowcat_Out")
	character.camera.camera_height = 2.2
	
func update(delta):
	pass

func nextState():
	if !character.animPlayer.is_playing():
		character.global_position += character.quaternion * Vector3.LEFT
		character.set_active(true)
		return IdleState.new(character)
	return self
