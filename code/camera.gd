extends Camera3D

@export var origin: Node3D
@export var look_target : Node3D
var distance = 5.0
var origin_height = 1.5
var camera_height = 2.5
var is_cutscene = false

func _process(delta):
	delta = clamp(delta, 0.0, 1.0)
	if !is_cutscene:
		var origin_to_camera = origin.global_position.direction_to(global_position).normalized() * distance
		origin_to_camera.y = 0
		var local_pos = origin_to_camera + Vector3.UP * camera_height
		global_position = origin.global_position + local_pos
		look_at(origin.global_position + Vector3.UP * origin_height)
	else:
		global_position = lerp(global_position, origin.global_position, delta)
		var target_distance = global_position.distance_to(look_target.global_position)
		var look_dir = lerp(quaternion * Vector3.FORWARD * target_distance, look_target.global_position - global_position, delta)
		look_at(global_position + look_dir)
