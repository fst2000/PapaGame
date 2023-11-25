class_name Attack

var animName : String
var force : Vector2
var damage : int
var hitTime : float
var endTime : float
var flyoff : bool
func _init(animName : String, force : Vector2, damage : int, hitTime : float, flyoff : bool):
	self.animName = animName
	self.force = force
	self.damage = damage
	self.hitTime = hitTime
	self.endTime = endTime
	self.flyoff = flyoff
