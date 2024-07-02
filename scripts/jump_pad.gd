extends Node2D

@export_subgroup("Settings")
@export var animation_player: AnimationPlayer
@export var spring_sfx: AudioStreamPlayer2D

func _on_jump_area_body_exited(body: Node2D) -> void:
	
	if animation_player.is_playing() and animation_player.current_animation == "jump":
		return

	if body is Player:
		body.jump_component.handle_jump_pad(body)
	
		animation_player.play("jump")
		spring_sfx.play()
		await animation_player.animation_finished
		animation_player.play("idle")
