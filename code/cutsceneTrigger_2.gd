extends Area3D

@export var camera : Node3D
@export var papa : Node3D
@export var look_target : Node3D
@export var camera_origin : Node3D
var action_list := ActionList.new()

func _on_body_entered(body):
	if body is Papa:
		action_list.add(
			func():
				$CollisionShape3D.disabled = true
				camera.is_cutscene = true
				camera.look_target = look_target
				camera.origin = camera_origin
				papa.controller.is_active = false
				papa.lookDir(papa.global_position.direction_to(look_target.global_position)),
			TimeCondition.new(4))
		action_list.add(
			func():
				papa.speakSystem.say("Похоже, спуск заледенел"),
			papa.speakSystem)
		action_list.add(
			func():
				papa.speakSystem.say("")
				camera.is_cutscene = false
				camera.look_target = papa
				camera.origin = papa
				papa.controller.is_active = true,
			FalseCondition.new())

func _process(delta):
	action_list.update()

