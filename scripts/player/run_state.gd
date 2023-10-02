extends PlayerState

func enter(msg = {}) -> void:
	player.animation_player.play()


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
		return
		
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
		return
	
	var direction = player.get_move_direction()
	
	if direction == Vector3.ZERO:
		state_machine.transition_to("Idle")
		return
		
	
	if Input.is_action_pressed("sprint"):
		player.target_velocity.x = direction.x * player.sprint_speed
		player.target_velocity.z = direction.z * player.sprint_speed
		player.animation_player.speed_scale = 6
	else:
		player.target_velocity.x = direction.x * player.speed
		player.target_velocity.z = direction.z * player.speed
		player.animation_player.speed_scale = 4
	
	player.target_velocity.y = 0
	
	#player.velocity = player.target_velocity
	#player.move_and_slide()
