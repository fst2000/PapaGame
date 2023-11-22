extends Area3D

@export var camera : Node3D
@export var papa : Node3D
@export var bully : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Papa:
		set_monitoring(false)
		camera.origin = $CameraOrigin
		camera.look_target = bully
		bully.target = $BullyTarget
