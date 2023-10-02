extends PlayerState

func enter(msg := {}) -> void:
	player.animation_player.speed_scale = 1
	player.animation_player.play("float")
	
	
func update(delta: float) -> void:
	var direction = player.get_move_direction()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
		return
		
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
		return
		
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
		return
		
	if direction != Vector3.ZERO:
		state_machine.transition_to("Run")
		return
		
	player.target_velocity = Vector3.ZERO
