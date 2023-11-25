class_name Bully

extends CharacterBody3D

var walkSpeed = 2
var gravity = -10
var jumpForce = 5
var hp = 100
var attackTimer = DeltaTimer.new()

@export var target : Node3D

@onready var status = CharacterStatus.new(hp)
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller = EnemyController.new(self, target, $NavigationAgent3D, attackTimer)
@onready var hitSystem := CharacterHitSystem.new(self, RayHitDetector.new($RayCast3D))
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var attacks : Array[Attack] = [
	Attack.new("Punch1", Vector2(2,0), 5, 0.4, false),
	Attack.new("Punch2",Vector2(2,0), 5, 0.4, false),
	Attack.new("Kick1",Vector2(2,0), 10, 0.4, false)]
@onready var fightSystem := AttackSystem.new(attacks)
@onready var state = IdleState.new(self)

func _process(delta):
	
	controller.set_target(target)
	
	state = state.nextState()
	state.update(delta)

	if is_on_floor() && velocity.y < 0: velocity.y = 0;
	else: velocity.y += gravity * delta
	move_and_slide()
	status.update(delta)
	attackTimer.update(delta)

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
	return Vector3.BACK.rotated(Vector3.UP, rotation.y)
