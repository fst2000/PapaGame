class_name Papa

extends CharacterBody3D

@export var camera: Camera3D
var walkSpeed = 4
var gravity = -10
var jumpForce = 5
var hp = 100
@onready var status = CharacterStatus.new(hp)
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sounds = $Sounds
@onready var controller : PapaController = PapaController.new(self)
@onready var hitSystem := CharacterHitSystem.new(self, AreaHitDetector.new($HitArea))
@onready var speakSystem := TextSpeakSystem.new($text)
@onready var punches : Array[Attack] = [
	Attack.new("Punch1", Vector2(1,0), 10, 0.15, false),
	Attack.new("Punch2", Vector2(1,0), 10, 0.15, false),
	Attack.new("Punch3", Vector2(1,6), 15, 0.2, true)]
@onready var kicks : Array[Attack] = [
	Attack.new("Kick1", Vector2(1,0), 5, 0.08, false),
	Attack.new("Kick2", Vector2(1,0), 10, 0.15, false),
	Attack.new("Kick3", Vector2(8,5), 20, 0.4, true)]
@onready var fallKicks : Array[Attack] = [Attack.new("FallKick", Vector2(5,5), 20, 0.2, true)]
@onready var punchSystem := AttackSystem.new(punches)
@onready var kickSystem := AttackSystem.new(kicks)
@onready var fallKickSystem := AttackSystem.new(fallKicks)
@onready var fightSystem := PapaFightSystem.new(self, punchSystem, kickSystem, fallKickSystem)
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
	direction.y = 0
	if direction.length() > 0:
		look_at(global_position - direction)

func jump():
	velocity.y += jumpForce

func forward() -> Vector3:
	return quaternion * Vector3.BACK
