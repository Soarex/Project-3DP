extends PlayerState

func enter(msg = {}) -> void:
	player.animation_player.stop()


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	if player.is_on_floor():
		state_machine.transition_to("Idle")
		return
		
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
		return
	
	player.target_velocity.y = player.target_velocity.y - (player.fall_acceleration * delta)
	
	var direction = player.get_move_direction()
	
	if direction == Vector3.ZERO:
		return
		
	if Input.is_action_pressed("sprint"):
		player.target_velocity.x = direction.x * player.sprint_speed
		player.target_velocity.z = direction.z * player.sprint_speed
	else:
		player.target_velocity.x = direction.x * player.speed
		player.target_velocity.z = direction.z * player.speed
