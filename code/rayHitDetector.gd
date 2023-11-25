class_name RayHitDetector

var ray : RayCast3D

func _init(ray : RayCast3D):
	self.ray = ray

func hit_objects() -> Array[Object]:
	return [ray.get_collider()]
