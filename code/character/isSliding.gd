class_name IsSliding

var area : Area3D

func _init(area : Area3D):
	self.area = area

func check() -> bool:
	var colliders = area.get_overlapping_bodies()
	if colliders.size() != 0:
		var material = colliders[0].get_physics_material_override()
		if material != null:
			return material.get_friction() < 0.1
	return false
