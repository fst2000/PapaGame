extends CharacterBody3D
@export var forward_direction : Vector3
var is_active = false
var move_speed = 10
var gravity = -10
@onready var sparks = $sparks


func _ready():
	sparks.visible = false

func _process(delta):
	if is_active:
		var input = Input.get_axis("right", "left")
		sparks.visible = true
		var move_velocity = forward_direction * move_speed
		velocity.x = move_velocity.x
		velocity.z = move_velocity.z
	else:
		sparks.visible = false
	if is_on_floor():
		velocity.y = 0
		var look_direction = get_floor_normal()
		look_at(global_position - velocity)
	else:
		velocity.y += gravity * delta
	move_and_slide()

func forward() -> Vector3:
	return quaternion * Vector3.BACK
