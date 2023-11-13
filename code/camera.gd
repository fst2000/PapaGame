extends Camera3D

@export var origin: Node3D

var distance = 5.0
var originHeight = 1.5
var minHeight = 3.0
var maxHeight = 4.0

func _ready():
	pass

func _process(delta):
	var origPos = origin.global_position
	#var distance = origPos.distance_to(position)
	var camHeight = global_position.y - origPos.y
	var clampedHeight = clamp(camHeight, minHeight, maxHeight)
	var lerpHeight = lerp(camHeight, clampedHeight, 0.3)
	global_position.y = origPos.y + lerpHeight
	var camPos = origPos + (origPos.direction_to(global_position) * distance)
	global_position = camPos
	
	if global_position - origPos != Vector3.ZERO:
		look_at(origPos + Vector3.UP * originHeight)
