extends Area3D

@export var camera : Node3D
@export var papa : Node3D
@export var bullies : Array[Node3D]

var action_list := ActionList.new()

func _on_body_entered(body):
	var bully = bullies[0]
	action_list.add(
		func():
			$CollisionShape3D.disabled = true
			camera.origin = $CameraOrigin
			camera.is_cutscene = true
			camera.look_target = bully
			papa.controller.is_active = false,
		FalseCondition.new())
	
	action_list.add(
		func():
			bully.speakSystem.say("Крутые сани у тебя, пацан"),
		bully.speakSystem)
	action_list.add(
		func():
			bully.speakSystem.say("Дай покататься"),
		bully.speakSystem)
	action_list.add(
		func():
			bully.speakSystem.say("")
			camera.is_cutscene = false
			camera.look_target = papa
			camera.origin = papa
			papa.controller.is_active = true
			for b in bullies:
				b.target = papa,
		FalseCondition.new())
	action_list.add(
		func(): pass,
		FuncCondition.new(
			func():
				return bullies.any(
					func(bully):
						return bully.status.isAlive())))
	action_list.add(
		func():
			papa.speakSystem.say("Сдачи не надо"),
		papa.speakSystem)
func _process(delta):
	action_list.update()
