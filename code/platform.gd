extends AnimatableBody3D

@export var amplitude : float
@export var speed : float
@export var direction : Vector3 = Vector3.UP
@onready var startPos = global_position
var offset = Vector3.ZERO
var time = 0.0

func _process(delta):
	offset = sin(time * speed * delta) * amplitude
	global_position = startPos + direction * offset
	time += delta
