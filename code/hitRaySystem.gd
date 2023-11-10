class_name HitRaySystem

var hitRay : RayCast3D
var hitSource : Node3D
func _init(hitSource, hitRay : RayCast3D):
	self.hitRay = hitRay
	self.hitSource = hitSource

func hit(damage : int):
	var collider = hitRay.get_collider()
	if hitRay.is_colliding() && collider is CharacterBody3D:
		collider.status.hasDamaged = true
		var hitVelocity = (hitSource.quaternion * Vector3.BACK).normalized() * clamp(damage * 0.1, 0, 10)
		collider.status.hitVelocity = hitVelocity
		collider.status.hp -= damage
		hitSource.sounds.get_node("Hit").play()
