class_name Papa

extends CharacterBody3D

@export var camera: Camera3D
var walkSpeed = 4
var gravity = -10
var jumpForce = 5

@onready var status = CharacterStatus.new()
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller : PapaController = PapaController.new(self)
@onready var hitSystem := HitAreaSystem.new(self, $Area3D)
@onready var punches : Array[Attack] = [
	Attack.new("Punch1", 10, 0.2),
	Attack.new("Punch2", 10, 0.2),
	Attack.new("Punch3", 15, 0.2)]
@onready var kicks : Array[Attack] = [
	Attack.new("Kick1", 5, 0.1),
	Attack.new("Kick2", 10, 0.2),
	Attack.new("Kick3", 20, 0.4)]

@onready var fightSystem := PapaFightSystem.new(self, punches, kicks)
@onready var state = IdleState.new(self)

func _process(delta):
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
	if direction.length() > 0:
		look_at(global_position - direction)

func jump():
	velocity.y += jumpForce

func forward() -> Vector3:
	return quaternion * Vector3.BACK
