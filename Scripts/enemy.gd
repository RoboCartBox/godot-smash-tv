extends CharacterBody2D
class_name Enemy

@export var animation_tree : AnimationTree
var player: Node2D = null
var playback: AnimationNodeStateMachinePlayback

func _ready():
	playback = animation_tree["parameters/playback"]
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		playback.travel("Moving")
