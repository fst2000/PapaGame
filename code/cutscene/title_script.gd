extends Node3D

var time = 0.0

func _process(delta):
	time += delta * 3.0
	scale = Vector3(1,1,1) * (1.0 - (0.5 * sin(time)) * 0.1)
