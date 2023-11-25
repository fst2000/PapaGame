class_name DeltaTimer

var time = 0.0
var is_active = false

func start():
	is_active = true
	time = 0

func update(delta):
	if is_active: time += delta

func stop():
	is_active = false
	time = 0

func time_passed() -> float:
	return time
