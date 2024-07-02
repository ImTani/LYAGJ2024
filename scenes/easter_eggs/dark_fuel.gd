extends Node2D

@export_subgroup("Settings")
@export var animated_sprite: AnimatedSprite2D

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		var color_tween: Tween = create_tween()
		color_tween.tween_property(animated_sprite, "modulate", Color.WHITE, 1)
