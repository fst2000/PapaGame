class_name CharacterStatus

var hp = 100
var hasDamaged = false
var hitVelocity = Vector3.ZERO

func _init(hp : int = 100):
	self.hp = hp

func update(delta):
	hp = clamp(hp, 0, 100)

func isAlive():
	return hp > 0
