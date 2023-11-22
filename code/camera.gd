extends Camera3D

@export var origin: Node3D
@export var look_target : Node3D
var distance = 5.0
var originHeight = 1.5
var minHeight = 3.0
var maxHeight = 4.0

func _ready():
	pass

func _process(delta):
	if origin is CharacterBody3D:
		var origPos = origin.global_position
		#var distance = origPos.distance_to(position)
		var camHeight = global_position.y - origPos.y
		var clampedHeight = clamp(camHeight, minHeight, maxHeight)
		var lerpHeight = lerp(camHeight, clampedHeight, 0.3)
		global_position.y = origPos.y + lerpHeight
		var rayDirection = (origPos.direction_to(global_position) * distance)
		var camPos = origPos + rayDirection
		global_position = camPos
		look_at(origPos + Vector3.UP * originHeight)
	else:
		global_position = lerp(global_position, origin.global_position, delta)
		look_at(look_target.position)
		
