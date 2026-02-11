extends CharacterBody2D

@export var speed: float = 120.0
@export var attack_range: float = 40.0

var player: Node2D = null

func _ready():
	# Find the player via group (clean and flexible)
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta):
	if player == null:
		return

	var direction = player.global_position - global_position
	var distance = direction.length()

	if distance > attack_range:
		# Move toward player
		velocity = direction.normalized() * speed
	else:
		# Stop when in attack range
		velocity = Vector2.ZERO
		attack()

	move_and_slide()

	# Optional: rotate to face player
	rotation = direction.angle()

func attack():
	print("Enemy attacking player!")
