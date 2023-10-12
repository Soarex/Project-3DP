class_name Player
extends CharacterBody3D

signal hit

@export var speed := 14
@export var sprint_speed := 19
@export var fall_acceleration := 75
@export var jump_impulse := 20
@export var bounce_impulse := 16
@export var camera_follow_speed := 8
@export var attack_duration := 1

var target_velocity := Vector3.ZERO

@onready var input: CharacterInput = $PlayerCharacterInput
@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var pivot: Node3D = $Pivot
@onready var particle_system: GPUParticles3D = $Pivot/ParticleSystem
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func get_move_direction() -> Vector3:
	var rotated_direction = input.direction
	rotated_direction = rotated_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	if rotated_direction != Vector3.ZERO:
		rotated_direction = rotated_direction.normalized()
	
	return rotated_direction


func handle_rotation(delta: float) -> void:
	pivot.rotation.x = PI / 6 * velocity.y / jump_impulse
	var look_direction = Vector2(-velocity.z, -velocity.x)
	
	if(look_direction):
		pivot.rotation.y = lerp_angle(pivot.rotation.y, look_direction.angle(), delta * 12)


func _physics_process(delta: float) -> void:
	velocity = target_velocity
	move_and_slide()
	
	handle_rotation(delta)
	spring_arm.position = lerp(spring_arm.position, position, delta * camera_follow_speed)


func check_collisions() -> void:
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		if (collision.get_collider() == null):
			continue
			
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y = bounce_impulse


func die() -> void:
	hit.emit()
	queue_free()


func _on_mob_detector_body_entered(body) -> void:
	die()
