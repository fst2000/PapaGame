class_name HitSystem

var ray : RayCast3D

func _init(ray : RayCast3D):
	self.ray = ray

func hit(damage : int):
	if ray.is_colliding() && ray.get_collider() is CharacterBody3D:
		ray.get_collider().damage(damage)
