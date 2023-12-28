class_name Bully

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
@onready var controller = BullyController.new(self, target, $NavigationAgent3D)
@onready var middleHitSystem := CharacterHitSystem.new(self, RayHitDetector.new($MiddleHitRay))
@onready var lowHitSystem := CharacterHitSystem.new(self, RayHitDetector.new($LowHitRay))
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var attacks : Array[Attack] = [
	Attack.new(middleHitSystem, "Punch1", Vector3(0, 0, 1), Vector2(2,0), 5, 0.4, 0.45, false),
	Attack.new(middleHitSystem, "Punch2", Vector3(0, 0, 1), Vector2(2,0), 5, 0.4, 0.45, false),
	Attack.new(lowHitSystem, "Kick1", Vector3(0, 0, 1), Vector2(2,0), 10, 0.4, 0.45, false)]
@onready var fightSystem := AttackSystem.new(attacks)
@onready var stepCondition = FalseCondition.new()
@onready var koAction
@onready var state = IdleState.new(self)

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
