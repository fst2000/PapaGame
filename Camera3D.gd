extends Camera3D

@export var _origin: Node3D

var _distance = 5
var _minHeight = 2
var _maxHeight = 3

func _ready():
	pass

func _process(delta):
	var origPos = _origin.position
	#var distance = origPos.distance_to(position)
	var camHeight = position.y - origPos.y
	var clampedHeight : float = clamp(camHeight, _minHeight, _maxHeight)
	var lerpHeight = lerp(camHeight, clampedHeight, 0.1)
	position.y = origPos.y + lerpHeight
	var camPos = origPos + (origPos.direction_to(position) * _distance)
	position = camPos
		
	look_at(origPos)
