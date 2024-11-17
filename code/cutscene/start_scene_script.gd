extends Node3D

@onready var camera = $Camera3D
@onready var path_follow = $Path3D/PathFollow3D

@onready var path_progress = path_follow.progress_ratio

var speed_mul = 0.0

func _ready():
	camera.global_position = path_follow.global_position
	create_tween().tween_property(self, "speed_mul", 0.02, 2.0)

func _process(delta):
	path_progress += delta * speed_mul
	path_progress = path_progress - int(path_progress)
	path_follow.progress_ratio = path_progress
	camera.global_position = lerp(camera.global_position, path_follow.global_position, delta * 2)
	camera.look_at(camera.global_position + lerp(-camera.global_basis.z, -path_follow.global_basis.z, delta))
	
	if Input.is_action_just_pressed("enter"):
		var fade_rect = $CanvasLayer/FadeRect
		fade_rect.visible = true
		var tween = create_tween()
		tween.tween_property(fade_rect, "color", Color(0,0,0,1.0), 1.0)
		tween.tween_callback(func():
			get_tree().change_scene_to_file("res://scenes/levels/level_apartment.tscn"))
