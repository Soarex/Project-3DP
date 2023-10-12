extends PlayerState

func check_transitions() -> bool:
	if player.is_on_floor():
		state_machine.transition_to("Idle")
		return true
		
	if player.input.attack_requested:
		state_machine.transition_to("Attack")
		return true
		
	return false


func enter(msg = {}) -> void:
	player.animation_player.stop()
	
	
func exit() -> void:
	player.input.jump_requested = false


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	if check_transitions():
		return
	
	player.target_velocity.y = player.target_velocity.y - (player.fall_acceleration * delta)
	
	var direction = player.get_move_direction()
	
	if direction == Vector3.ZERO:
		return
	
	var speed := 0.0
	if player.input.sprinting:
		speed = player.sprint_speed
	else:
		speed = player.speed
		
	player.target_velocity.x = direction.x * player.input.input_magnitude * speed
	player.target_velocity.z = direction.z * player.input.input_magnitude * speed
