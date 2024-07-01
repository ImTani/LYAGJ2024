extends Node2D

@export_file("*.tscn") var game_scene: String
@export_file("*.tscn") var credits_scene: String
@export var options_container: Control
@export var buttons_container: Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(game_scene)

func _on_options_button_pressed() -> void:
	buttons_container.visible = false
	options_container.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_close_button_pressed() -> void:
	buttons_container.visible = true
	options_container.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if options_container.visible:
			buttons_container.visible = true
			options_container.visible = false

func _on_credits_button_pressed() -> void:
		get_tree().change_scene_to_file(credits_scene)
