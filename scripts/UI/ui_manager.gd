extends CanvasLayer

@onready var pause_menu = %PauseMenu

func _toggle_pause_menu() -> void:
	pause_menu.pause()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause_menu()
