class_name Papa

extends CharacterBody3D

@export var camera: Camera3D
var target : Node3D
var walkSpeed = 4
var jumpSpeed = 4
var gravity = -10
var jumpForce = 5
var hp = 100
var max_target_angle = 60
var is_active = true

@onready var status = CharacterStatus.new(hp)
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller : PapaController = PapaController.new(self)
@onready var middleHitSystem := CharacterHitSystem.new(self, AreaHitDetector.new($MiddleHitArea))
@onready var lowHitSystem := CharacterHitSystem.new(self, AreaHitDetector.new($LowHitArea))
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var punches : Array[Attack] = [
	Attack.new(middleHitSystem, "Punch1", Vector3(0, 0, 1), Vector2(1,0), 10, 0.15, 0.25, false),
	Attack.new(middleHitSystem, "Punch2", Vector3(0, 0, 2), Vector2(1,0), 10, 0.15, 0.25, false),
	Attack.new(middleHitSystem, "Punch3", Vector3(0, 0, 2), Vector2(1,5.5), 15, 0.2, 0.3, true)]
@onready var kicks : Array[Attack] = [
	Attack.new(lowHitSystem, "Kick1", Vector3(0, 0, 1), Vector2(1,0), 5, 0.08, 0.16, false),
	Attack.new(middleHitSystem, "Kick2", Vector3(0, 0, 2), Vector2(1,0), 10, 0.15, 0.25, false),
	Attack.new(middleHitSystem, "Kick3", Vector3(0, 0, 2), Vector2(8,5), 20, 0.4, 0.5, true)]
@onready var fallKicks : Array[Attack] = [Attack.new(lowHitSystem, "FallKick", Vector3(0, 0, 0), Vector2(5,4), 15, 0.2, 0.3, true)]
@onready var dodgePunch := Attack.new(middleHitSystem, "DodgePunch", Vector3(0,0,1), Vector2(2, 5), 15, 0.15, 0.32, true)
@onready var punchSystem := AttackSystem.new(punches)
@onready var kickSystem := AttackSystem.new(kicks)
@onready var fallKickSystem := AttackSystem.new(fallKicks)
@onready var fightSystem := PapaFightSystem.new(self, punchSystem, kickSystem, fallKickSystem, dodgePunch) 
@onready var targetDefiner = AngleTargetDefiner.new(self, AreaHitDetector.new($TargetArea), max_target_angle)
@onready var slideCondition = IsSliding.new($GroundArea)
@onready var stepCondition = $StepCondition
@onready var koAction = func(): get_tree().current_scene.restart()
@onready var state = IdleState.new(self)

func _process(delta):
	controller.update(delta)
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
	if direction.length() > 0.01:
		look_at(global_position - direction)

func jump():
	velocity.y += jumpForce
	sounds.get_node("Jump").play()

func forward() -> Vector3:
	return quaternion * Vector3.BACK

func dodge():
	$CollisionShape3D.disabled = true
	$DodgeShape.disabled = false
	
func undodge():
	$CollisionShape3D.disabled = false
	$DodgeShape.disabled = true

func set_active(value : bool):
	is_active = value
	set_collision_layer_value(2, value)
	set_collision_mask_value(1, value)
	set_collision_mask_value(3, value)
	set_collision_mask_value(4, value)
	set_collision_mask_value(6, value)
	
