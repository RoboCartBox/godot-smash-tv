extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D
var speed: float = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += Vector2(1, 0).rotated(rotation) * speed * delta
	

func _on_distance_timeout_timeout() -> void:
	queue_free()
