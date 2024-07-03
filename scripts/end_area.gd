extends Area2D

@export_subgroup("Settings")
@export var animation_player: AnimationPlayer
@export var ending_music: AudioStream

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("light up")

func change_music() -> void:
	utils.change_bg(ending_music)
