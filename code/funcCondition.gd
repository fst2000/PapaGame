class_name FuncCondition

var func_condition : Callable

func _init(func_condition : Callable):
	self.func_condition = func_condition

func check():
	return func_condition.call()
