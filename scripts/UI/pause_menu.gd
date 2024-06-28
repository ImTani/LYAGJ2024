extends Control

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
	get_tree().reload_current_scene() #TODO fix this!


func _on_main_menu_button_pressed() -> void:
	pass # Replace with function body. #TODO make main menu


func _on_music_slider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_sfx_slider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_shadows_checkbox_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_subtitles_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_lighting_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
