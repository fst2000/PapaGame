class_name TextSpeakSystem

var label : Node3D
var words
func _init(label):
	self.label = label

func say(words : String):
	label.write(words)
	self.words = words
	
func check():
	var words_time = words.length() * 0.1
	return label.text_time < clamp(words_time, 3, words_time)
