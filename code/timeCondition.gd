class_name TimeCondition

var start_time
var time : float
func _init(time : float): #time in sec
	self.time = time
	self.start_time = Time.get_ticks_msec() * 0.001

func check():
	var cur_time = Time.get_ticks_msec() * 0.001
	return cur_time - start_time < time
