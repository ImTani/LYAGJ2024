extends Node2D

@export_subgroup("Lights")
@export var light1: PointLight2D

func randomize_light_intensity() -> void:
	var random_float: float = randf_range(0.05, 0.1)

	light1.texture_scale = random_float
