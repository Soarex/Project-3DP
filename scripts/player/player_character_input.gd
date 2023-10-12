class_name PlayerCharacterInput
extends CharacterInput

func _process(delta: float) -> void:
	jump_requested = jump_requested || Input.is_action_just_pressed("jump")
	attack_requested = attack_requested || Input.is_action_just_pressed("attack")
	sprinting = Input.is_action_pressed("sprint")
	
	direction = Vector3.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	
	input_magnitude = clampf(direction.length(), 0, 1)
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
