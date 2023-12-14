class_name CharacterHitSystem

var hitDetector
var hitSource : Node3D

func _init(hitSource, hitDetector):
	self.hitDetector = hitDetector
	self.hitSource = hitSource

func hit(hit_info):
	var bodies = hitDetector.hit_objects()
	if bodies.size() > 0:
		hitSource.status.hasHit = true
		hitSource.sounds.get_node("Hit").play()
	for body in bodies:
		if body is CharacterBody3D:
			var hitVelocity = hitSource.quaternion * Vector3.BACK * hit_info.force.x + Vector3.UP * hit_info.force.y
			body.status.hasDamaged = true
			body.status.hitVelocity = hitVelocity
			body.status.hp -= hit_info.damage
			body.status.flyoff = hit_info.flyoff
