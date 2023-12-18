class_name Papa

extends CharacterBody3D

@export var camera: Camera3D
var target : Node3D
var walkSpeed = 4
var gravity = -10
var jumpForce = 5
var hp = 100
var max_target_angle = 60
var is_active = true

@onready var status = CharacterStatus.new(hp)
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller : PapaController = PapaController.new(self)
@onready var hitSystem := CharacterHitSystem.new(self, AreaHitDetector.new($HitArea))
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var punches : Array[Attack] = [
	Attack.new("Punch1", Vector3(0, 0, 1), Vector2(1,0), 10, 0.15, false),
	Attack.new("Punch2", Vector3(0, 0, 2), Vector2(1,0), 10, 0.15, false),
	Attack.new("Punch3", Vector3(0, 0, 2), Vector2(1,5.5), 15, 0.2, true)]
@onready var kicks : Array[Attack] = [
	Attack.new("Kick1", Vector3(0, 0, 1), Vector2(1,0), 5, 0.08, false),
	Attack.new("Kick2", Vector3(0, 0, 2), Vector2(1,0), 10, 0.15, false),
	Attack.new("Kick3", Vector3(0, 0, 2), Vector2(8,5), 20, 0.4, true)]
@onready var fallKicks : Array[Attack] = [Attack.new("FallKick", Vector3(0, 0, 0), Vector2(5,5), 20, 0.2, true)]
@onready var punchSystem := AttackSystem.new(punches)
@onready var kickSystem := AttackSystem.new(kicks)
@onready var fallKickSystem := AttackSystem.new(fallKicks)
@onready var fightSystem := PapaFightSystem.new(self, punchSystem, kickSystem, fallKickSystem)
@onready var actionSystem = AreaActionSystem.new(AreaToAreaDetector.new($ActionArea), self)
@onready var targetDefiner = AngleTargetDefiner.new(self, AreaHitDetector.new($TargetArea), max_target_angle)
@onready var slideCondition = IsSliding.new($GroundArea)
@onready var stepCondition = $StepCondition
@onready var state = IdleState.new(self)
func _process(delta):
	state = state.nextState()
	state.update(delta)
	if is_on_floor() && velocity.y < 0: velocity.y = 0;
	else:
		if is_active:
			velocity.y += gravity * delta
	move_and_slide()
	status.update(delta)

func _physics_process(delta):
	status.slide = slideCondition.check()
	target = targetDefiner.get_target()

func move(v: Vector3):
	velocity.x = v.x
	velocity.z = v.z

func lookDir(direction : Vector3):
	direction.y = 0
	if direction.length() > 0:
		look_at(global_position - direction)

func jump():
	velocity.y += jumpForce

func forward() -> Vector3:
	return quaternion * Vector3.BACK
func set_active(value : bool):
	is_active = value
	set_collision_layer_value(2, value)
	set_collision_mask_value(1, value)
	set_collision_mask_value(3, value)
	set_collision_mask_value(4, value)
	set_collision_mask_value(5, value)
	
