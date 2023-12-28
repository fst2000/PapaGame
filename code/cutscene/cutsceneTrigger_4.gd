extends Area3D


@export var camera : Node3D
@export var papa : Node3D
@export var snowcat : Node3D
var action_list := ActionList.new()

func _process(delta):
	action_list.update()
	
func _on_body_entered(body):
	#var bully = bullies[0]
	action_list.add(
		func():
			$CollisionShape3D.disabled = true
			camera.is_cutscene = true
			camera.origin = $CameraOrigin
			camera.look_target = papa
			snowcat.is_active = false
			papa.controller.is_active = false,
		FuncCondition.new(func(): return !(snowcat.on_ground_condition.check() && snowcat.velocity.length() < 0.1)))
	
	action_list.add(
		func():
			papa.state = OutSnowcatState.new(papa)
			snowcat.should_get_in = false,
		TimeCondition.new(1.0))
	
	action_list.add(
		func():
			camera.is_cutscene = false
			camera.origin = papa
			camera.look_target = papa
			papa.controller.is_active = true,
		FalseCondition.new()
	)
