extends Node2D

@export_file("*.tscn") var main_menu_scene: String

func _on_close_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(main_menu_scene)
