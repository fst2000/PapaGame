class_name AreaActionSystem

var area_detector
var actor : Node3D

func _init(area_detector, actor):
	self.area_detector = area_detector
	self.actor = actor

func action():
	print("action")
	var objects : Array = area_detector.hit_objects()
	if objects:
		print("action object")
		objects.front().get_parent().area_action(actor)
