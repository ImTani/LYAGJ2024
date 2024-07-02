extends Control
class_name OptionsMenu

@export_subgroup("Settings")
@export var voice_line: AudioStream
@export var audio_player: AudioStreamPlayer

@export_subgroup("Volume Sliders")
@export var overall_volume_slider: HSlider
@export var music_volume_slider: HSlider
@export var sfx_volume_slider: HSlider
@export var voice_volume_slider: HSlider

@export_subgroup("Check Buttons")
@export var shadows_toggle_button: CheckButton
@export var subtitles_toggle_button: CheckButton
@export var light_environment_toggle_button: CheckButton
@export var full_screen_toggle_button: CheckButton

@export_subgroup("Audio Busses")
@export var master_bus: StringName = &"Master"
@export var sfx_bus: StringName = &"SFX"
@export var music_bus: StringName = &"Music"
@export var voice_bus: StringName = &"Voice"

var overall_volume_setting: StringName = "configuration/audio/overall_volume"
var sfx_volume_setting: StringName = "configuration/audio/sfx_volume"
var music_volume_setting: StringName = "configuration/audio/music_volume"
var voice_volume_setting: StringName = "configuration/audio/voice_volume"

var shadows_setting: StringName = "configuration/graphics/shadows"
var subtitles_setting: StringName = "configuration/graphics/subtitles"
var light_environment_setting: StringName = "configuration/graphics/light_environment"
var fullscreen_setting: StringName = "configuration/graphics/fullscreen"

var override_path: StringName = "res://override.cfg"

var master_bus_idx: int
var sfx_bus_idx: int
var music_bus_idx: int
var voice_bus_idx: int

func _ready() -> void:
	audio_player.stream = voice_line

	load_audio_busses()
	load_audio_settings()
	load_toggle_settings()
	

func load_audio_busses() -> void:
	master_bus_idx = AudioServer.get_bus_index(master_bus)
	sfx_bus_idx = AudioServer.get_bus_index(sfx_bus)
	music_bus_idx = AudioServer.get_bus_index(music_bus)
	voice_bus_idx = AudioServer.get_bus_index(voice_bus)

func load_audio_settings() -> void:
	overall_volume_slider.value = ProjectSettings.get_setting(overall_volume_setting)
	sfx_volume_slider.value = ProjectSettings.get_setting(sfx_volume_setting)
	music_volume_slider.value = ProjectSettings.get_setting(music_volume_setting)
	voice_volume_slider.value = ProjectSettings.get_setting(voice_volume_setting)

func set_bus_volume(setting: StringName, bus_idx: int, volume_value: float) -> void:
	ProjectSettings.set_setting(setting, volume_value)
	AudioServer.set_bus_volume_db(bus_idx , linear_to_db(volume_value))
	ProjectSettings.save_custom(override_path)

func _on_overall_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(overall_volume_setting, master_bus_idx, value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(music_volume_setting, music_bus_idx, value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(sfx_volume_setting, sfx_bus_idx, value)

func _on_voice_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(voice_volume_setting, voice_bus_idx, value)

func _on_voice_volume_slider_drag_started() -> void:
	audio_player.play()

#Toggles

func load_toggle_settings() -> void:
	light_environment_toggle_button.button_pressed = ProjectSettings.get_setting(light_environment_setting)
	shadows_toggle_button.button_pressed = ProjectSettings.get_setting(shadows_setting)
	subtitles_toggle_button.button_pressed = ProjectSettings.get_setting(subtitles_setting)
	full_screen_toggle_button.button_pressed = ProjectSettings.get_setting(fullscreen_setting)

func toggle_setting(setting: StringName, toggled_on: bool) -> void:
	ProjectSettings.set_setting(setting, toggled_on)
	ProjectSettings.save_custom(override_path)

func _on_light_environment_toggled(toggled_on: bool) -> void:
	toggle_setting(light_environment_setting, toggled_on)

func _on_subtitles_toggled(toggled_on: bool) -> void:
	toggle_setting(subtitles_setting, toggled_on)

func _on_shadows_checkbox_toggled(toggled_on: bool) -> void:
	toggle_setting(shadows_setting, toggled_on)

func _on_full_screen_toggled(toggled_on: bool) -> void:
	toggle_setting(fullscreen_setting, toggled_on)
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
