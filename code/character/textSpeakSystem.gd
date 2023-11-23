class_name TextSpeakSystem

var text : Node3D

func _init(text):
	self.text = text

func say(words : String):
	text.write(words)
