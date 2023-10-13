class_name PaintDrawer
extends SubViewport

@onready var brush: Brush = $Brush

func paint(position : Vector2, color := Color(1, 1, 1)) -> void:
	brush.queue_brush(position * (size as Vector2), color)
