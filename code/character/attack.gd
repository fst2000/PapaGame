class_name Attack

var hitSystem
var animName : String
var move_velocity : Vector3
var force : Vector2
var damage : int
var startHitTime : float
var endHitTime : float
var flyoff : bool
func _init(hitSystem, animName : String, move_velocity : Vector3, force : Vector2, damage : int, startHitTime : float, endHitTime : float, flyoff : bool):
	self.hitSystem = hitSystem
	self.animName = animName
	self.move_velocity = move_velocity
	self.force = force
	self.damage = damage
	self.startHitTime = startHitTime
	self.endHitTime = endHitTime
	self.flyoff = flyoff
