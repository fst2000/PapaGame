class_name ActionList

var list : Array
var action
var condition
var has_action = false

func add(action : Callable, continue_condition):
	list.push_back(action)
	list.push_back(continue_condition)
	
func update():
	if list.size() != 0:
		if !has_action:
			action = list[0]
			condition = list[1]
			action.call()
			has_action = true
		if !condition.check():
			has_action = false
			list.pop_front()
			list.pop_front()
