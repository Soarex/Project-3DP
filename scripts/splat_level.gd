extends Node3D

@onready var paint_drawer: PaintDrawer = $PaintDrawer
@onready var player: Player = $Player
@onready var levelGeometry: MeshInstance3D = $Platform

@onready var uv_calculator: UVPositionCalculator = UVPositionCalculator.new(levelGeometry)

func _physics_process(delta: float) -> void:
	for i in range(0, player.get_slide_collision_count()):
		var col = player.get_slide_collision(i)
		var uv = uv_calculator.get_uv_coords(col.get_position(), col.get_normal(), true)
		if uv:
			paint_drawer.paint(uv, Color(0, 0.3, 1))
