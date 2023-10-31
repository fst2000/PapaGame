var _body
func _init(body : CharacterBody3D):
	_body = body
func update(delta : float):
	print("landing")
func nextState():
	return load("res://idleState.gd").new(_body)
