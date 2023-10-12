extends PlayerState

var start_time := 0.0

func check_transitions() -> bool:
	if Time.get_unix_time_from_system() - start_time > player.attack_duration:
		state_machine.transition_to("Idle")
		return true
		
	return false


func enter(msg = {}) -> void:
	player.animation_player.stop()
	start_time = Time.get_unix_time_from_system()


func exit() -> void:
	player.input.attack_requested = false
	player.character.rotation.z = 0
	

func update(delta: float) -> void:
	if check_transitions():
		return
	
	player.character.rotate_z((PI * player.attack_rotation_speed) * delta)

func physics_update(delta: float) -> void:
	for index in range(player.get_slide_collision_count()):
		var collision = player.get_slide_collision(index)
		
		if (collision.get_collider() == null):
			continue
			
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			mob.squash()
			
	player.target_velocity = player.pivot.basis * (Vector3.FORWARD * player.attack_dash_speed)


func _on_attack_end() -> void:
	state_machine.transition_to("Idle")
