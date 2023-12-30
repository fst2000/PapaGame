extends Area3D

@export var camera : Node3D
@export var papa : Node3D
@export var enemies : Array[CharacterBody3D]
var action_list := ActionList.new()

func _process(delta):
	action_list.update()
	
func _on_body_entered(body):
	var enemy = enemies[0]
	
	action_list.add(
		func():
			$CollisionShape3D.disabled = true
			camera.is_cutscene = true
			camera.origin = $CameraOrigin
			camera.look_target = enemy
			papa.controller.is_active = false
			for e in enemies:
				e.lookDir(papa.global_position - e.global_position)
			enemy.speakSystem.say("Эээээ Фффсссшшш"),
		enemy.speakSystem)
	
	action_list.add(
		func():
			enemy.speakSystem.say("Вытряхивай карманы"),
		enemy.speakSystem)

	action_list.add(
		func():
			enemy.speakSystem.say("")
			camera.look_target = papa
			papa.speakSystem.say("Чьи карманы, твои?"),
		papa.speakSystem)

	action_list.add(
		func():
			enemy.speakSystem.say("Эээ не понял")
			camera.look_target = enemy
			papa.speakSystem.say(""),
		enemy.speakSystem)
		
	action_list.add(
		func():
			enemy.speakSystem.say("")
			camera.look_target = papa
			camera.origin = $CameraOrigin2
			papa.speakSystem.say("Сейчас поймешь"),
		papa.speakSystem)
	
	action_list.add(
		func():
			papa.speakSystem.say("")
			for e in enemies:
				e.target = papa,
		FalseCondition.new())
	
	action_list.add(
		func():
			camera.is_cutscene = false
			camera.origin = papa
			camera.look_target = papa
			papa.controller.is_active = true,
		FalseCondition.new())
