extends Node3D

var action_list := ActionList.new()
@onready var origin = $CutsceneOrigin
@onready var look_target = $CutsceneOrigin/CutsceneLookTarget
@onready var anim_player = $AnimationPlayer
@export var camera : Camera3D
@export var papa : Node3D

func _ready():
	camera.is_cutscene = true
	camera.origin = origin
	camera.look_target = look_target
	papa.controller.is_active = false
	
	action_list.add(
		func():
			anim_player.play("Cutscene_Hood_1"),
		FuncCondition.new(func(): return anim_player.is_playing()))
	
	action_list.add(func(): pass, TimeCondition.new(1.0))
	
	action_list.add(
		func(): papa.speakSystem.say("Давно такого снега не было"),
		papa.speakSystem)
	
	action_list.add(func(): papa.speakSystem.say(""),FalseCondition.new())
	
	action_list.add(
		func():
			camera.is_cutscene = false
			camera.origin = papa
			camera.look_target = papa
			papa.controller.is_active = true,
		FalseCondition.new())

func _process(delta):
	action_list.update()
