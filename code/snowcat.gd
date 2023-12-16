extends CharacterBody3D
@export var forward_direction : Vector3
var input = 0.0
var is_active = false
var has_activated = false
var has_landed = false
var move_speed = 10
var gravity = -10
var input_strength = 6
var velocity_quaternion  = Quaternion()
@onready var sparks = $sparks
@onready var slide_sound = $Sounds/Slide
@onready var sparks_sound = $Sounds/Sparks
func _ready():
	sparks.visible = false

func _process(delta):
	if is_active:
		sparks.visible = true
		if !has_activated:
			sparks_sound.play()
			has_activated = true
		input = lerp(input, Input.get_axis("right", "left"), 5 * delta)
		if is_on_floor():
			if !has_landed:
				slide_sound.play()
				has_landed = true
			var move_quaternion = Quaternion(Vector3.BACK, forward_direction)
			var floor_quaternion = Quaternion(Vector3.UP, get_floor_normal())
			var input_vector = move_quaternion * Vector3(input,0,0)
			var move_velocity = forward_direction * move_speed + input_vector * input_strength
			velocity_quaternion = lerp(velocity_quaternion, Quaternion(forward_direction, move_velocity.normalized()), 10 * delta)
			var snowcat_quaternion = velocity_quaternion * floor_quaternion
			quaternion = lerp(quaternion, snowcat_quaternion, 10 * delta)
			velocity.x = lerp(velocity.x, move_velocity.x, 5 * delta) 
			velocity.y = 0
			velocity.z = lerp(velocity.z, move_velocity.z, 5 * delta) 
		else:
			if has_landed:
				slide_sound.stop()
				has_landed = false
			velocity.y += gravity * delta
	else:
		sparks.visible = false
		if has_activated:
			sparks_sound.stop()
			has_activated = false
	move_and_slide()

func forward() -> Vector3:
	return quaternion * Vector3.BACK
