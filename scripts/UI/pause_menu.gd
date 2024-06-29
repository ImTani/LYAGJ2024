extends Control

@export_file("*.tscn") var main_menu_scene: String

func pause() -> void:
	if not visible:
		visible = true
		get_tree().paused = true
	else:
		visible = false
		get_tree().paused = false

func _on_resume_button_pressed() -> void:
	pause()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file(utils.game_scene)

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene)
