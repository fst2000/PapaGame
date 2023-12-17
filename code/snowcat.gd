extends CharacterBody3D

var input = 0.0
var is_active = false
var has_activated = false
var has_landed = false
var move_speed = 20
var gravity = -10
var rotation_angle = 45
var velocity_quaternion  = Quaternion()
var should_get_out = false

@onready var forward_direction = quaternion * Vector3.FORWARD
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
			var normal = get_floor_normal()
			var model_right = quaternion * Vector3.RIGHT
			var velocity_right = velocity.dot(model_right)
			var look_forward = normal.cross(model_right)
			var look_forward_rotated = look_forward.rotated(normal, input * (rotation_angle * PI / 180))
			
			look_at(global_position + look_forward_rotated)
			velocity = quaternion * Vector3.BACK * move_speed
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

func area_action(actor : Node3D):
	is_active = !is_active
	actor.state = InSnowcatState.new(actor, self, FuncCondition.new(func(): return should_get_out))

func forward() -> Vector3:
	return quaternion * Vector3.BACK
