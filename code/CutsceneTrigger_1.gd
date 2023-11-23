extends Area3D

@export var camera : Node3D
@export var papa : Node3D
@export var bully : Node3D

func _on_body_entered(body):
	if body is Papa:
		set_monitoring(false)
		camera.origin = $CameraOrigin
		camera.look_target = bully
		bully.target = $BullyTarget
		bully.speakSystem.say("А вот и мы, давай сюда деньги")
