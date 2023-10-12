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
		
	if player.input.direction != Vector3.ZERO:
		state_machine.transition_to("Run")
		return true
		
	return false


func enter(msg := {}) -> void:
	player.animation_player.speed_scale = 1
	player.animation_player.play("float")
	
	
func update(delta: float) -> void:
	if check_transitions():
		return
		
	player.target_velocity = Vector3.ZERO
