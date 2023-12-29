class_name InSnowcatState

var exit_condition
var character

func _init(character, snowcat, exit_condition):
	self.exit_condition = exit_condition
	self.character = character
	character.reparent(snowcat)
	character.set_active(false)
	character.position = Vector3.ZERO
	character.quaternion = Quaternion()
	character.animPlayer.play("Snowcat_In")
	character.camera.origin = snowcat
	character.camera.camera_height = 1

func update(delta):
	pass

func nextState():
	if exit_condition.check():
		return OutSnowcatState.new(character)
	return self
