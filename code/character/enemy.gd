class_name Enemy

extends CharacterBody3D

var walkSpeed = 2
var gravity = -10
var jumpForce = 5
var hasMoved = false

@export var target : Node3D

@onready var status = CharacterStatus.new(30)
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller = EnemyController.new(self, target, $NavigationAgent3D)
@onready var hitSystem := HitRaySystem.new(self, $RayCast3D)
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var punches : Array[Attack] = [
	Attack.new("Punch1", 5, 0.24),
	Attack.new("Punch2", 5, 0.24),
	Attack.new("Punch3", 5, 0.24)]
@onready var kicks : Array[Attack] = [
	Attack.new("Kick1", 10, 0.24)]
@onready var punchSystem = AttackSystem.new(punches)
@onready var kickSystem = AttackSystem.new(kicks)
@onready var fightSystem := BullyFightSystem.new(self, punchSystem, kickSystem)
@onready var state = IdleState.new(self)

func _process(delta):
	
	controller.set_target(target)
	
	state = state.nextState()
	state.update(delta)

	if is_on_floor() && velocity.y < 0: velocity.y = 0;
	else: velocity.y += gravity * delta
	if hasMoved:
		move_and_slide()
		hasMoved = false
	status.update(delta)

func move(v: Vector3):
	velocity.x = v.x
	velocity.z = v.z
	hasMoved = true

func lookDir(direction : Vector3):
	if(direction.length() > 0):
		look_at(global_position - direction)

func jump():
	velocity.y += jumpForce

func forward() -> Vector3:
	return Vector3.BACK.rotated(Vector3.UP, rotation.y)
