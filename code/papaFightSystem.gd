class_name PapaFightSystem

var animPlayer : AnimationPlayer
var controller : PapaController
var hitSystem
var moveSystem
var punches : Array[Attack]
var kicks : Array[Attack]
var attackTimer : Timer = Timer.new()
var punchCount = 0
var kickCount = 0
func _init(papa : Papa, punches : Array[Attack], kicks : Array[Attack]):
	self.animPlayer = papa.animPlayer
	self.controller = papa.controller
	self.hitSystem = papa.hitSystem
	self.punches = punches
	self.kicks = kicks

func attack() -> Attack:
	var attack
	if controller.shouldPunch():
		attack = punches[punchCount]
		if punchCount == punches.size() - 1: punchCount = 0
		else : punchCount += 1
	elif controller.shouldKick():
		attack = kicks[kickCount]
		if kickCount == kicks.size() - 1: kickCount = 0
		else : kickCount += 1
	return attack

func reset():
	punchCount = 0
	kickCount = 0
