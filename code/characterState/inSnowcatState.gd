class_name InSnowcatState

var character

func _init(character, snowcat):
	self.character = character
	character.reparent(snowcat)
	character.set_active(false)
	character.position = Vector3.ZERO
	character.quaternion = Quaternion()
	character.animPlayer.play("Snowcat_In")
	character.camera.origin = snowcat
	character.camera.camera_height = 1
	snowcat.should_get_in = false

func update(delta):
	pass

func nextState():
	return self
