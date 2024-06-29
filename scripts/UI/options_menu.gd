extends Control
class_name OptionsMenu

@export var overall_volume_slider: HSlider
@export var music_volume_slider: HSlider
@export var sfx_volume_slider: HSlider
@export var voice_volume_slider: HSlider

@export var master_bus: StringName = &"Master"
@export var sfx_bus: StringName = &"SFX"
@export var music_bus: StringName = &"Music"
@export var voice_bus: StringName = &"Voice"

var overall_volume_setting: StringName = "configuration/audio/overall_volume"
var sfx_volume_setting: StringName = "configuration/audio/sfx_volume"
var music_volume_setting: StringName = "configuration/audio/music_volume"
var voice_volume_setting: StringName = "configuration/audio/voice_volume"
var override_path: StringName = "res://override.cfg"

var master_bus_idx: int
var sfx_bus_idx: int
var music_bus_idx: int
var voice_bus_idx: int

func _ready() -> void:
	load_audio_busses()
	load_audio_settings()

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

func set_bus_volume(setting: String, bus_idx: int, volume_value: float) -> void:
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
