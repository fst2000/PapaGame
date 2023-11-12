class_name HitAreaSystem

var hitArea : Area3D
var hitSource : Node3D
func _init(hitSource, hitArea : Area3D):
	self.hitArea = hitArea
	self.hitSource = hitSource

func hit(damage : int):
	var bodies = hitArea.get_overlapping_bodies()
	for body in bodies:
		body.status.hasDamaged = true
		var hitVelocity = (hitSource.quaternion * Vector3.BACK).normalized() * damage * 0.1
		body.status.hitVelocity = hitVelocity
		body.status.hp -= damage
		hitSource.sounds.get_node("Hit").play()
