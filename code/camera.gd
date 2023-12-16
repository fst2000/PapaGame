extends Camera3D

@export var origin: Node3D
@export var look_target : Node3D
@onready var raycast : RayCast3D = $RayCast3D
var distance = 4.0
var origin_height = 1.5
var camera_height = 2.5
var is_cutscene = false

func _process(delta):
	delta = clamp(delta, 0.0, 1.0)
	if !is_cutscene:
		var look_point = origin.global_position + Vector3.UP * origin_height
		look_at(look_point)
		var local_pos = Vector3(0, camera_height, distance).rotated(Vector3.UP, rotation.y)
		var global_pos = origin.global_position + local_pos
		var pre_check_vector = quaternion * Vector3.FORWARD * 0.2
		var ray_vector = global_pos - look_point - pre_check_vector
		raycast.global_position = look_point
		raycast.target_position = quaternion.inverse() * ray_vector
		if raycast.is_colliding():
			print("colliding")
			var collision_point = raycast.get_collision_point() + pre_check_vector
			global_position = look_point + ray_vector.normalized() * look_point.distance_to(collision_point)
		else: global_position = global_pos
	else:
		global_position = lerp(global_position, origin.global_position, delta)
		var target_distance = global_position.distance_to(look_target.global_position)
		var look_dir = lerp(quaternion * Vector3.FORWARD * target_distance, look_target.global_position - global_position, delta)
		look_at(global_position + look_dir)
