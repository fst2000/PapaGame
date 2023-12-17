class_name AreaToAreaDetector

var area : Area3D

func _init(area):
	self.area = area

func hit_objects() -> Array[Area3D]:
	return area.get_overlapping_areas()
