extends Camera3D

@export var origin: Node3D
@export var look_target : Node3D
@onready var raycast : RayCast3D = $RayCast3D
var distance = 5.0
var origin_height = 1.5
var camera_height = 2.2
var rotation_speed = 0.003
var is_cutscene = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	delta = clamp(delta, 0.0, 1.0)
	if !is_cutscene:
		var look_point = origin.global_position + Vector3.UP * origin_height
		var local_pos =  quaternion * Vector3(0, 0, distance) + Vector3.UP * camera_height
		var global_pos = origin.global_position + local_pos
		var pre_check_vector = quaternion * Vector3.FORWARD * 0.3
		var ray_vector = global_pos - look_point - pre_check_vector
		raycast.global_position = look_point
		raycast.target_position = quaternion.inverse() * ray_vector
		if raycast.is_colliding():
			var collision_point = raycast.get_collision_point() + pre_check_vector
			var final_pos = look_point + ray_vector.normalized() * lerp(look_point.distance_to(global_position), look_point.distance_to(collision_point), delta * 20)
			global_position = final_pos
		else: global_position = global_pos
	else:
		global_position = lerp(global_position, origin.global_position, 3 * delta)
		var target_distance = global_position.distance_to(look_target.global_position)
		var look_dir = lerp(quaternion * Vector3.FORWARD * target_distance, look_target.global_position + Vector3.UP - global_position, 3 * delta)
		look_at(global_position + look_dir)

func _input(event):
	if !is_cutscene:
		if event is InputEventMouseMotion:
			rotate(Vector3.UP, -event.relative.x * rotation_speed)
			rotate(quaternion * Vector3.RIGHT, -event.relative.y * rotation_speed)
			var max_radian = 60 * PI / 180
			rotation.x = clamp(rotation.x, -max_radian, max_radian)
			rotation.z = 0
