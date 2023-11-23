class_name IsMoving

var character

func _init(character):
	self.character = character

func check() -> bool:
	return character.controller.shouldMove()
