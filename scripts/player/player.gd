class_name Player
extends CharacterBody3D

signal hit

@export var speed := 14.0
@export var sprint_speed := 19.0
@export var fall_acceleration := 75.0
@export var jump_impulse := 20.0
@export var bounce_impulse := 16.0
@export var camera_follow_speed := 8.0
@export var attack_duration := 0.5
@export var attack_dash_speed := 20.0
@export var attack_rotation_speed := 36.0

var target_velocity := Vector3.ZERO

@onready var input: CharacterInput = $PlayerCharacterInput
@onready var spring_arm: SpringArm3D = $CameraSpringArm
@onready var pivot: Node3D = $Pivot
@onready var character: Node3D = $Pivot/Character
@onready var particle_system: GPUParticles3D = $Pivot/ParticleSystem
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func get_camera_space_direction() -> Vector3:
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


func die() -> void:
	hit.emit()
	queue_free()

