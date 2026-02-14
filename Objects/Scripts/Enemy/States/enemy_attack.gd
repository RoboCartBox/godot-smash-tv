extends EnemyState

func physics_process_state(delta: float):
	
	var direction := player.global_position - enemy.global_position
	
	var distance = direction.length()
	
	if distance > enemy.attack_range:
		transitioned.emit(self, "idle")
		return
		
	print("attacking")
	
	enemy.velocity = direction.normalized()*enemy.attacking_movement_speed
	
	enemy.move_and_slide()
