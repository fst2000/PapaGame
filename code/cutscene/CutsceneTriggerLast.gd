extends Area3D

@export var papa : Node3D
@export var papa_cake : Node3D
@export var camera : Node3D
@export var black_screen : Control
@export var health_bar : Control
@onready var origin = $CameraOrigin
@onready var origin_1 = $CameraOrigin1
@onready var origin_2 = $CameraOrigin2
@onready var target = $CameraTarget
var action_list := ActionList.new() 

func _process(delta):
	action_list.update()

func _on_body_entered(body):
	action_list.add(
		func():
			health_bar.queue_free()
			papa.controller.is_active = false
			camera.is_cutscene = true
			camera.origin = origin_1
			camera.look_target = target,
		TimeCondition.new(3.0))

	action_list.add(
		func():
			camera.look_target = papa
			papa.speakSystem.say("Вот и пришли"),
			papa.speakSystem)
	
	action_list.add(
		func():
			camera.look_target = papa
			papa.speakSystem.say("Надеюсь, тортик еще есть"),
			papa.speakSystem)
			
	action_list.add(
		func():
			camera.look_target = papa
			papa.speakSystem.say("")
			black_screen.transition_action = func():pass
			black_screen.appear(),
			TimeCondition.new(1.0))
	
	action_list.add(
		func():
			camera.look_target = papa_cake
			papa.queue_free()
			papa_cake.visible = true,
		TimeCondition.new(1.0))
	
	action_list.add(
		func():
			black_screen.fade()
			$TrainAnimation.play("TrainStart"),
		TimeCondition.new(1.0))
		
	action_list.add(
		func():
			camera.look_target = $train,
		TimeCondition.new(1.5))
		
	action_list.add(
		func():
			camera.look_target = papa_cake
			papa_cake.speakSystem.say("Как раз трамвай"),
		papa_cake.speakSystem)
	
	action_list.add(
		func():
			black_screen.appear(),
		TimeCondition.new(1.0))
	
	action_list.add(
		func():
			camera.look_target = $train
			camera.origin = origin
			$TrainAnimation.play("TrainStart2")
			papa_cake.speakSystem.say(""),
		TimeCondition.new(1.0))
	
	action_list.add(
		func():
			black_screen.fade(),
		TimeCondition.new(5.0))

	action_list.add(
		func():
			black_screen.appear(),
		TimeCondition.new(1.0))

	action_list.add(
		func():
			$TrainAnimation.play("TrainEnd"),
		TimeCondition.new(2.0))
	
	action_list.add(
		func():
			black_screen.fade(),
		TimeCondition.new(10.0))
	
	action_list.add(
		func():
			black_screen.transition_action = func(): get_tree().change_scene_to_file("res://scenes/levels/apartment_end.tscn")
			black_screen.appear(),
		TimeCondition.new(1.0))
