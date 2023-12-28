class_name Hooder

extends CharacterBody3D

var walkSpeed = 2
var jumpSpeed = 2
var gravity = -10
var jumpForce = 5
var hp = 60

@export var target : Node3D

@onready var status = CharacterStatus.new(hp)
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller = HooderController.new(self, target, $NavigationAgent3D)
@onready var hitSystem := CharacterHitSystem.new(self, AreaHitDetector.new($HitArea))
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var attacks : Array[Attack] = [
	Attack.new(hitSystem, "SlideKick", Vector3(0, 0, 5), Vector2(6,4), 15, 0.15, 0.9, true)]
@onready var fightSystem := AttackSystem.new(attacks)
@onready var stepCondition = FalseCondition.new()
@onready var koAction
@onready var state = IdleState.new(self)

func _ready():
	$snow_spray.visible = false

func _process(delta):
	
	controller.set_target(target)
	
	state = state.nextState()
	state.update(delta)

	if is_on_floor() && velocity.y < 0: velocity.y = 0;
	else: velocity.y += gravity * delta
	move_and_slide()
	status.update(delta)

func move(v: Vector3):
	velocity.x = v.x
	velocity.z = v.z

func lookDir(direction : Vector3):
	direction.y = 0
	if direction.length() > 0.01:
		look_at(global_position - direction)

func jump():
	velocity.y += jumpForce

func forward() -> Vector3:
	return quaternion * Vector3.BACK
	
func set_active(value : bool):
	set_collision_layer_value(3, value)
	set_collision_mask_value(2, value)
	set_collision_mask_value(3, value)
	set_collision_mask_value(4, value)
