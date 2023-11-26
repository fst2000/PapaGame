class_name CharacterStatus

var fullHP
var hp
var hasDamaged = false
var hitVelocity = Vector3.ZERO
var flyoff = false
var slide = false

func _init(hp):
	self.fullHP = hp
	self.hp = hp

func update(delta):
	hp = clamp(hp, 0, fullHP)

func isAlive():
	return hp > 0
