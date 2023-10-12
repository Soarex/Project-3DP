extends PlayerState

func enter(msg = {}) -> void:
	player.input.attack_requested = false
	player.animation_player.speed_scale = 1
	player.animation_player.play("attack")


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	pass

func _on_attack_end() -> void:
	state_machine.transition_to("Idle")
