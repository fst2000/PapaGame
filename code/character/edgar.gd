extends CharacterBody3D

@onready var animPlayer = $AnimationPlayer
@onready var speakSystem = TextSpeakSystem.new($text)
var look_target
func _ready():
	animPlayer.play("Idle")

func _process(delta):
	if look_target:
		var look_position = look_target.global_position
		look_position.y = global_position.y
		look_at(look_position)
		rotation.y += PI
