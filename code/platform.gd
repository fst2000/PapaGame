extends AnimatableBody3D

@export var amplitude : float
@export var speed : float
@onready var startPos = global_position
var offset = Vector3.ZERO
var time = 0.0

func _process(delta):
	offset = sin(time * speed * delta) * amplitude
	global_position = startPos + Vector3.UP * offset
	time += delta
