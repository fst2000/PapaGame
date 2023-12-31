extends Node3D

var action_list := ActionList.new()

@onready var me_anim = $Me/MeAnim
@onready var tq_anim = $Taqmuraz/TqAnim
@onready var papa_anim = $Armature/PapaAnim
@onready var camera_anim = $Camera/CameraAnim
@onready var black_screen = $CanvasLayer/BlackScreen
@onready var credits = $CanvasLayer/Credits

var has_ended = false

func _ready():
	$CanvasLayer/Label.hide()
	$Cake_001.visible = false
	$Cake_002.visible = false
	$Cake_003.visible = false
	$Cake_sliced.visible = false
	credits.visible = false
	
	action_list.add(
		func():
			$CristmasTreeEnd.play()
			black_screen.fade()
			camera_anim.play("CameraAnim/Camera1")
			camera_anim.speed_scale = 0.5
			papa_anim.play("PapaAnim/PapaCake1")
			papa_anim.speed_scale = 0.5
			me_anim.play("MeAnim/MeHide")
			me_anim.stop()
			tq_anim.play("TqAnim/TqHide")
			tq_anim.stop(),
		TimeCondition.new(2.0))
		
	action_list.add(
		func():
			me_anim.play("MeAnim/MeHide")
			tq_anim.play("TqAnim/TqHide"),
			TimeCondition.new(2.0))
	
	action_list.add(
		func():
			black_screen.appear(),
		TimeCondition.new(1.0))
	
	action_list.add(
		func():
			black_screen.fade()
			$Cake.visible = false
			$Cake_001.visible = true
			$Cake_002.visible = true
			$Cake_003.visible = true
			$Cake_sliced.visible = true
			camera_anim.play("CameraAnim/Camera2")
			papa_anim.play("PapaAnim/PapaCake2")
			me_anim.play("MeAnim/MeCake")
			tq_anim.play("TqAnim/TqCake"),
		TimeCondition.new(12.0))

	action_list.add(
		func():
			black_screen.appear()
			credits.visible = true,
			TimeCondition.new(5.0))
	
	action_list.add(
		func():
			has_ended = true
			$CanvasLayer/Label.visible = true,
		FalseCondition.new())
	
func _process(delta):
	action_list.update()
	if has_ended:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
