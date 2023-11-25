class_name AngleTargetDefiner

var body : Node3D
var detector
var max_angle : float
func _init(body, detector, max_angle : float):
	self.max_angle = max_angle
	self.body = body
	self.detector = detector

func get_target() -> Node3D:
	var targets : Array[Node3D] = detector.hit_objects()
	targets = targets.filter(func(target):
		var radians = body.forward().angle_to(body.global_position.direction_to(target.global_position))
		return radians / PI * 180 < max_angle)
	if targets.size() == 0:
		return null
	var closest_target = targets[0]
	var distance = body.global_position.distance_to(closest_target.global_position)
	var i = 1
	while i < targets.size():
		var target = targets[i]
		var target_distance = body.global_position.distance_to(target.global_position)
		if target_distance < distance:
			distance = target_distance
			closest_target = target
		i+=1
	return closest_target
