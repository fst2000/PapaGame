class_name Attack

var animName : String
var damage : int
var hitTime : float
var endTime : float
func _init(animName : String, damage : int, hitTime : float, endTime : float):
	self.animName = animName
	self.damage = damage
	self.hitTime = hitTime
	self.endTime = endTime
