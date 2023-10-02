extends "res://scripts/player/player_state.gd"

func enter(msg = {}):
	player.target_velocity.y = player.jump_impulse
	player.animation_player.stop()
	state_machine.transition_to("Fall")


func update(delta):
	pass


func physics_update(delta):
	pass

