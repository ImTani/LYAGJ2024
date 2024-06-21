extends Node2D
class_name Item

@export var sprite: Sprite2D

func _process(delta: float) -> void:
	print(name, global_position)
