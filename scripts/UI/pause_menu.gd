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
	get_tree().reload_current_scene() #FIXME fix scene reloads!
