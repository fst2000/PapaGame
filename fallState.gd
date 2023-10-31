var _body
func _init(body : CharacterBody3D):
	_body = body
func update(delta : float):
	print("falling")
func nextState():
	if _body.is_on_floor():
		return load("res://landState.gd").new(_body)
	else: return self
