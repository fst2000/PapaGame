extends Camera3D

@export var origin: Node3D

var distance = 5.0
var minHeight = 3.0
var maxHeight = 3.0

func _ready():
	pass

func _process(delta):
	var origPos = origin.position
	#var distance = origPos.distance_to(position)
	var camHeight = position.y - origPos.y
	var clampedHeight = clamp(camHeight, minHeight, maxHeight)
	var lerpHeight = lerp(camHeight, clampedHeight, 0.2)
	position.y = origPos.y + lerpHeight
	var camPos = origPos + (origPos.direction_to(position) * distance)
	position = camPos
		
	look_at(origPos)
