class_name TimeCondition

var is_started = false
var start_time = 0.0
var cur_time = 0.0
var time : float
func _init(time : float): #time in sec
	self.time = time

func check():
	if !is_started:
		start_time = Time.get_ticks_msec()
		is_started = true
	cur_time = Time.get_ticks_msec() - start_time
	return cur_time * 0.001 < time
