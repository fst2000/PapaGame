extends Area3D

@export var camera : Node3D
@export var papa : Node3D
@export var edgar : Node3D
@export var bullies : Array[Node3D]
@export var snowcat : Node3D
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
			camera.origin = $CameraOrigin3
			camera.look_target = edgar
			edgar.speakSystem.say("Я даю кататься только друзьям"),
		edgar.speakSystem)

	action_list.add(
		func():
			camera.origin = $CameraOrigin
			camera.look_target = bully
			bully.speakSystem.say("Слышь малявка, не нарывайся")
			edgar.speakSystem.say("")
			edgar.animPlayer.play("Afraid"),
		bully.speakSystem)
	
	action_list.add(
		func():
			edgar.speakSystem.say("")
			edgar.animPlayer.play("Idle"),
		FalseCondition.new())
	
	action_list.add(
		func():
			camera.look_target = papa
			for b in bullies:
				b.lookDir(papa.global_position - b.global_position)
			papa.speakSystem.say("Эй, красная шапочка, отвали от мальчика"),
			papa.speakSystem)
	
	action_list.add(
		func():
			papa.speakSystem.say(""),
		FalseCondition.new())
	
	action_list.add(
		func():
			camera.look_target = bully
			bully.speakSystem.say("А то чё?"),
			bully.speakSystem)

	action_list.add(
		func():
			bully.speakSystem.say(""),
		FalseCondition.new())

	action_list.add(
		func():
			camera.origin = $CameraOrigin2
			papa.speakSystem.say("Через плечо"),
		papa.speakSystem)

	action_list.add(
		func():
			bully.speakSystem.say("")
			papa.speakSystem.say("")
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
			camera.is_cutscene = true
			papa.controller.is_active = false
			camera.origin = $CameraOrigin3
			camera.look_target = edgar
			edgar.look_target = papa,
		TimeCondition.new(1.0))

	action_list.add(
		func():
			edgar.animPlayer.play("Hura")
			edgar.speakSystem.say("Ураааа!"),
		FuncCondition.new(func(): return edgar.animPlayer.is_playing()))
	
	action_list.add(
		func():
			edgar.animPlayer.play("Idle")
			edgar.speakSystem.say("Здорово вы их проучили!"),
		edgar.speakSystem)
	
	action_list.add(
		func():
			edgar.speakSystem.say("Теперь мы друзья"),
		edgar.speakSystem)
		
	action_list.add(
		func():
			edgar.speakSystem.say("Можете прокатиться на санках, если хотите"),
		edgar.speakSystem)
	
	action_list.add(
		func():
			edgar.speakSystem.say("")
			camera.is_cutscene = false
			camera.look_target = papa
			camera.origin = papa
			papa.controller.is_active = true
			snowcat.should_get_in = true,
		FuncCondition.new(func(): return !(papa.state is InSnowcatState)))
	
	action_list.add(
		func():
			camera.is_cutscene = true
			camera.origin = $CameraOrigin4,
			TimeCondition.new(1.0))
		
	action_list.add(
		func():
			papa.speakSystem.say("Куда нажимать?"),
		papa.speakSystem)
	
	action_list.add(
		func():
			camera.look_target = edgar
			papa.speakSystem.say("")
			edgar.speakSystem.say("Там на руле кнопка"),
		edgar.speakSystem)
	
	action_list.add(
		func():
			camera.look_target = papa
			edgar.speakSystem.say("")
			papa.speakSystem.say("Вот эта?"),
		papa.speakSystem)
	
	action_list.add(
		func():
			snowcat.is_active = true
			papa.speakSystem.say("AAAAAAAAAAA"),
		papa.speakSystem)
		
	action_list.add(
		func():
			papa.speakSystem.say("")
			camera.is_cutscene = false
			camera.origin = snowcat,
		FalseCondition.new())
		
func _process(delta):
	action_list.update()
