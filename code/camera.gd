extends Camera3D

@export var origin: Node3D
@export var look_target : Node3D
var distance = 5.0
var originHeight = 1.5
var minHeight = 3.0
var maxHeight = 4.0
var is_cutscene = false

func _process(delta):
	if !is_cutscene:
		var origPos = origin.global_position
		#var distance = origPos.distance_to(position)
		var camHeight = global_position.y - origPos.y
		var clampedHeight = clamp(camHeight, minHeight, maxHeight)
		var lerpHeight = lerp(camHeight, clampedHeight, 0.3)
		global_position.y = origPos.y + lerpHeight
		var rayDirection = (origPos.direction_to(global_position) * distance)
		var camPos = origPos + rayDirection
		global_position = lerp(global_position, camPos, delta * 10)
		look_at(origPos + Vector3.UP * originHeight)
	else:
		global_position = lerp(global_position, origin.global_position, delta)
		var look_dir = lerp(quaternion * Vector3.FORWARD, look_target.global_position - global_position, delta)
		look_at(global_position + look_dir)
