class_name Attack

var animName : String
var move_velocity : Vector3
var force : Vector2
var damage : int
var hitTime : float
var endTime : float
var flyoff : bool
func _init(animName : String, move_velocity : Vector3, force : Vector2, damage : int, hitTime : float, flyoff : bool):
	self.animName = animName
	self.move_velocity = move_velocity
	self.force = force
	self.damage = damage
	self.hitTime = hitTime
	self.endTime = endTime
	self.flyoff = flyoff
