extends CanvasLayer

@export var pause_menu: Control
@export var subtitles: Control
@export var canvas_modulate: CanvasModulate
@export var player: Player

var light_for_others: PointLight2D

func _ready() -> void:
	light_for_others = player.light_for_others
	ProjectSettings.settings_changed.connect(_update_settings)
	_update_settings()

func _toggle_pause_menu() -> void:
	pause_menu.pause()

func _update_settings() -> void:
	light_for_others.shadow_enabled = ProjectSettings.get_setting("configuration/graphics/shadows")
	subtitles.visible = ProjectSettings.get_setting("configuration/graphics/subtitles")
	canvas_modulate.visible = not ProjectSettings.get_setting("configuration/graphics/light_environment")
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause_menu()
