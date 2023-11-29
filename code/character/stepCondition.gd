class_name StepCondition

extends Node3D

var has_step = false
var has_one_frame = false

func step():
	has_step = true
	
func check():
	return has_step

func _process(delta):
	if has_step:
		if has_one_frame:
			has_step = false
			has_one_frame = false
		else: has_one_frame = true
