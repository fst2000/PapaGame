extends Area3D


@onready var splash_scene = preload("res://scenes/particles/water_splash.tscn")


func _on_body_entered(body):
	body.status.hasDamaged = true
	body.status.hp = -10
