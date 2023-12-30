extends CharacterBody3D

var input = 0.0
var input_velocity = 0.0
var is_active = false
var has_activated = false
var has_landed = false
var move_speed = 15
var gravity = -10
var rotation_angle = 45
var velocity_quaternion  = Quaternion()
var should_get_in = false

@onready var forward_direction = quaternion * Vector3.FORWARD
@onready var sparks = $sparks
@onready var snow_sprays = $snow_sprays
@onready var slide_sound = $Sounds/Slide
@onready var sparks_sound = $Sounds/Sparks
@onready var ground_detector = AreaHitDetector.new($GroundArea)
@onready var on_ground_condition = FuncCondition.new(func(): return ground_detector.hit_objects().size() > 0)
@onready var groundRay = $RayCast3D
func _ready():
	sparks.visible = false
	snow_sprays.visible = false

func _process(delta):
	if is_active:
		sparks.visible = true
		if !has_activated:
			sparks_sound.play()
			has_activated = true
		input = Input.get_axis("right", "left")
		if on_ground_condition.check():
			if !has_landed:
				slide_sound.play()
				snow_sprays.visible = true
				has_landed = true
			input_velocity = lerp(input_velocity, input, 5 * delta)
			var normal = groundRay.get_collision_normal()
			var look_right = forward_direction.cross(Vector3.UP)
			var look_forward = -look_right.cross(normal)
			var input_rotation = input_velocity * rotation_angle
			var look_forward_rotated = look_forward.rotated(normal, input_rotation * PI / 180)
			look_at(global_position + look_forward_rotated)
			velocity = quaternion * Vector3.BACK * move_speed
			velocity.y -= 1.0
		else:
			if has_landed:
				slide_sound.stop()
				snow_sprays.visible = false
				has_landed = false
			velocity.y += gravity * delta
	else:
		sparks.visible = false
		if has_activated:
			sparks_sound.stop()
			snow_sprays.visible = false
			has_activated = false
		if on_ground_condition.check():
			velocity = lerp(velocity, Vector3.ZERO, delta * 2)
			look_at(global_position + forward_direction)
		else: velocity.y += gravity * delta
	move_and_slide()

func area_action(actor : Node3D):
	if should_get_in:
		actor.state = InSnowcatState.new(actor, self)
		$ActionArea/ActionShape.disabled = true

func get_out(driver):
	driver.state = OutSnowcatState.new(driver)

func forward() -> Vector3:
	return quaternion * Vector3.BACK
