var _body
func _init(body : CharacterBody3D):
	_body = body
func update(delta : float):
	print("idle")
func nextState():
	if !_body.is_on_floor():
		return load("res://fallState.gd").new(_body)
	else: return self
