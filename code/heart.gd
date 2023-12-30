extends Node3D

func _ready():
	$AnimationPlayer.play("Action")


func area_action(actor):
	actor.status.hp += 20
	queue_free()
