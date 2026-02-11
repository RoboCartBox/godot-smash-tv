class_name Enemy
extends CharacterBody2D

@export var speed: float = 120.0
@export var attack_range: float = 40.0
@export var detect_range: float = 80.0

@onready var animation_tree : AnimationTree = $AnimationTree

var player: Node2D = null
var playback: AnimationNodeStateMachinePlayback
var is_attacking: bool = false
var is_idle: bool = false
var is_spawning: bool = false

func _ready():
	is_spawning = true # will use later to play spawning animation
	playback = animation_tree["parameters/playback"]
	
	# Find the player via group (clean and flexible)
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta):
	if player == null:
		return

	var direction = player.global_position - global_position
	var distance = direction.length()
	
	if distance > detect_range:
		if !is_idle:
			is_idle = true
			print("Enemy too far from player - going idle")
			velocity = Vector2.ZERO
	elif distance > attack_range:
		is_idle = false
		if is_attacking == true:
			print("Stopped attacking")
			is_attacking = false
			# Move toward player
			print("Moving towards player")
		velocity = direction.normalized() * speed
	else:
		is_idle = false
		is_attacking = true
		# Stop when in attack range
		velocity = Vector2.ZERO
		attack()

	move_and_slide()
	update_animation_parameters()
	
func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true

	if is_attacking:
		animation_tree["parameters/conditions/is_attacking"] = true
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_moving"] = false
	# animation_tree["parameters/conditions/is_taking_damage"] = velocity
	
#	animation_tree["parameters/Spawning/blend_position"] = input
	animation_tree["parameters/Idle/blend_position"] = velocity.normalized()
	animation_tree["parameters/Attacking/blend_position"] = velocity.normalized()
	animation_tree["parameters/Moving/blend_position"] = velocity.normalized()
#	animation_tree["parameters/TakingDamage/blend_position"] = input

func attack():
	is_attacking = true
	print("Enemy attacking player")
