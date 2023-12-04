extends Area3D

@export var camera : Node3D
@export var papa : Node3D
@export var bullies : Array[Node3D]

var action_list := ActionList.new()

func _on_body_entered(body):
	print("Entered")
	
	var bully = bullies[0]
	action_list.add(
		func():
			$CollisionShape3D.disabled = true
			camera.origin = $CameraOrigin
			camera.is_cutscene = true
			camera.look_target = bully
			bullies[0].target = $BullyTarget1
			bullies[1].target = $BullyTarget2
			bullies[2].target = $BullyTarget3
			papa.controller.is_active = false,
			FalseCondition.new())
	action_list.add(
		func():
			bully.speakSystem.say("Эй!"),
			AreMoving.new(bullies))
	action_list.add(
		func():
			bully.speakSystem.say("А вот и мы, давай сюда деньги")
			papa.lookDir(bully.global_position - papa.global_position)
			for b in bullies:
				b.lookDir(papa.global_position - bully.global_position),
			bully.speakSystem)
	action_list.add(
		func():
			bully.speakSystem.say("")
			camera.look_target = papa
			papa.speakSystem.say("Фиг вам"),
			papa.speakSystem)
	action_list.add(
		func():
			papa.speakSystem.say("")
			camera.origin = papa
			camera.is_cutscene = false,
			FalseCondition.new())
	action_list.add(
		func():
			for b in bullies:
				b.target = papa
			papa.controller.is_active = true,
			FuncCondition.new(
				func():
					return bullies.any(
						func(bully):
							return bully.status.isAlive())))
	action_list.add(
		func():
			papa.speakSystem.say("Сдачи не надо"),
			papa.speakSystem)
	action_list.add(
		func():
			papa.speakSystem.say(""),
		FalseCondition.new())

func _process(delta):
	action_list.update()
