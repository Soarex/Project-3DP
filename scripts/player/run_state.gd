extends PlayerState

func check_transitions() -> bool:
	if player.input.jump_requested:
		state_machine.transition_to("Jump")
		return true
		
	if player.input.attack_requested:
		state_machine.transition_to("Attack")
		return true
		
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
		return true
		
	if player.input.direction == Vector3.ZERO:
		state_machine.transition_to("Idle")
		return true
	
	return false


func enter(msg = {}) -> void:
	player.animation_player.play("float")
	player.particle_system.emitting = true


func exit() -> void:
	player.particle_system.emitting = false


func physics_update(delta: float) -> void:
	if check_transitions():
		return
		
	var direction = player.get_move_direction()
	
	var speed := 0.0
	if player.input.sprinting:
		speed = player.sprint_speed
	else:
		speed = player.speed
		
	player.target_velocity.x = direction.x * player.input.input_magnitude * speed
	player.target_velocity.y = 0
	player.target_velocity.z = direction.z * player.input.input_magnitude * speed
	
	player.animation_player.speed_scale = maxf(player.target_velocity.length() * 0.25, 1)
