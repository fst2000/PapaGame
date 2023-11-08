class_name HitSystem

var ray : RayCast3D
var hitSound
func _init(hitSound, ray : RayCast3D):
	self.hitSound = hitSound
	self.ray = ray

func hit(damage : int):
	if ray.is_colliding() && ray.get_collider() is CharacterBody3D:
		ray.get_collider().damage(damage)
		hitSound.play()
