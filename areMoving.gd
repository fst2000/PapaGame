class_name AreMoving

var characters : Array

func _init(characters):
	self.characters = characters

func check() -> bool:
	var are_moving = false
	for c in characters:
		if c.controller.shouldMove(): are_moving = true
	return are_moving
