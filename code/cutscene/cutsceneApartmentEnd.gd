extends Node3D

var action_list := ActionList.new()

@onready var me_anim = $Me/MeAnim
@onready var tq_anim = $Taqmuraz/TqAnim
@onready var papa_anim = $Armature/PapaAnim
@onready var camera_anim = $Camera/CameraAnim

func _ready():
	action_list.add(
		func():
			camera_anim.play("CameraAnim/Camera1")
			papa_anim.play("PapaAnim/PapaCake1")
			me_anim.play("MeAnim/MeHide")
			tq_anim.play("TqAnim/TqHide"),
		TimeCondition.new(2.0))
			
	action_list.add(
		func():
			camera_anim.play("CameraAnim/Camera2")
			papa_anim.play("PapaAnim/PapaCake2")
			me_anim.play("MeAnim/MeCake")
			tq_anim.play("TqAnim/TqCake"),
		TimeCondition.new(2.0))

func _process(delta):
	action_list.update()
