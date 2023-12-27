class_name Gopnik

extends CharacterBody3D

var walkSpeed = 2
var gravity = -10
var jumpSpeed = 4
var jumpForce = 7
var hp = 60

@export var target : Node3D

@onready var status = CharacterStatus.new(hp)
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller = GopnikController.new(self, target, $NavigationAgent3D)
@onready var middleHitSystem := CharacterHitSystem.new(self, RayHitDetector.new($MiddleHitRay))
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var ground_attack = Attack.new(middleHitSystem, "Kick_1",  Vector3(0,0,1), Vector2(4,4), 10, 0.55, 0.6, true)
@onready var fall_attack = Attack.new(middleHitSystem, "Fall_Kick",  Vector3(0,0,1), Vector2(6,2), 10, 0.25, 1.0, true)
@onready var fightSystem := GopnikFightSystem.new(self, ground_attack, fall_attack)
@onready var stepCondition = $StepCondition
@onready var state = IdleState.new(self)

func _process(delta):
	
	controller.set_target(target)
	controller.update(delta)
	
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
