class_name RayHitDetector

var ray : RayCast3D

func _init(ray : RayCast3D):
	self.ray = ray

func hit_objects() -> Array[Object]:
	var collider = ray.get_collider()
	if collider:
		return [collider]
	else: return []
