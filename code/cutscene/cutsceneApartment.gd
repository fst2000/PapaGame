extends Node3D

@export var next_scene : Resource
@onready var papa_anim_player = $apartment/AnimationPlayer
@onready var anim_player = $AnimationPlayer
@onready var camera = $camera_origin/Camera3D
@onready var action_list := ActionList.new()
@onready var text = $apartment/text
func _ready():
	$CanvasLayer/BlackScreen.fade()
	anim_player.play("CameraOrigin1")
	start_cutscene()

func start_cutscene():
	action_list.add(
		func():
			anim_player.play("CameraOrigin2"),
		FuncCondition.new(func(): return anim_player.is_playing()))
	
	action_list.add(func():pass, TimeCondition.new(2.0))
	
	action_list.add(
		func():
			text.write("Что-то я зачитался")
			print(),
		TimeCondition.new(1.5))
		
	action_list.add(func():text.write(""), TimeCondition.new(0.2))
		
	action_list.add(
		func():
			anim_player.play("CameraLookAtWatches")
			papa_anim_player.play("Look_At_Watches"),
		TimeCondition.new(1.0))
	
	action_list.add(
		func():
			text.write("Уже девять часов"),
		TimeCondition.new(2.0))

	action_list.add(func():text.write(""), TimeCondition.new(0.2))
	
	action_list.add(
		func():
			text.write("До нового года всего 3 часа"),
		TimeCondition.new(3.0))
	
	action_list.add(func():text.write(""), TimeCondition.new(0.2))
	
	action_list.add(
		func():
			text.write("Схожу-ка я за тортиком"),
		TimeCondition.new(2.0))
	
	action_list.add(func():text.write(""), TimeCondition.new(0.5))
	
	action_list.add(
		func():
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$CanvasLayer/BlackScreen.transition_action = func():
				get_tree().change_scene_to_packed(next_scene)
			$CanvasLayer/BlackScreen.appear(),
		FalseCondition.new())
	
func  _process(delta):
	action_list.update()
