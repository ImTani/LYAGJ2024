extends Area2D

@export_subgroup("Settings")
@export var animation_player: AnimationPlayer
@export_file("*.tscn") var afterword_scene: String


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("end_credits")
		await animation_player.animation_finished
		get_tree().change_scene_to_file(afterword_scene)
