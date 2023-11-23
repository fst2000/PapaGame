class_name TimeAction

var action
var time
var timer
func _init(action : Callable, time : float):
	self.action = action
	self.time = time

func update(delta):
	timer += delta
	if timer < time:
		action.call()
