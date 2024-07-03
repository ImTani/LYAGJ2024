extends Area2D

@export_subgroup("Settings")
@export var dialogue_audio: AudioStream
@export var dialogue_texts: Dictionary
@export var dialogue_volume: float = -15
@export_enum("Voice Protagonist", "Voice Antagonist") var audio_bus: String

@export var dialogue_player_component: DialoguePlayerComponent

var played: bool = false

func _ready() -> void:
	dialogue_player_component.dialogue_audio = dialogue_audio
	dialogue_player_component.dialogue_texts = dialogue_texts
	dialogue_player_component.dialogue_volume = dialogue_volume
	dialogue_player_component.audio_bus = audio_bus

func _on_body_entered(body: Node2D) -> void:
	if utils.get_component(body, "InputComponent") and not played:
		dialogue_player_component.play_dialogue()
		played = true
