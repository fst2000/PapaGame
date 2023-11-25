class_name AreaHitDetector

var area : Area3D

func _init(area):
	self.area = area

func hit_objects() -> Array[Node3D]:
	return area.get_overlapping_bodies()
