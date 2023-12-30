extends Node3D

func _ready():
	$AnimationPlayer.play("Action")

	


func _on_area_3d_area_entered(area):
	area.get_parent().status.hp += 25
	queue_free()
