class_name TextSpeakSystem

var speaker : Node3D

func _init(speaker):
	self.speaker = speaker

func say(words : String):
	speaker.text.write(words)
