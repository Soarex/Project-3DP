extends SpringArm3D

@export var mouse_sensitivity := 0.05
@export var controller_sensitivity := 1

func _ready() -> void:
	top_level = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta: float) -> void:
	rotation_degrees.x -= (Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up")) * controller_sensitivity
	rotation_degrees.x = clamp(rotation_degrees.x, -60, -5)
	
	rotation_degrees.y -= -(Input.get_action_strength("camera_left") - Input.get_action_strength("camera_right")) * controller_sensitivity
	rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= -event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -60, -5)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
		
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
