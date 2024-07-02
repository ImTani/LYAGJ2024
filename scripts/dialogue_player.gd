extends Area2D

@export var dialogue_audio: AudioStream
@export var dialogue_texts: Dictionary
@export var dialogue_volume: float = -15
@export_enum("Voice Protagonist", "Voice Antagonist") var audio_bus: String

var played: bool = false

func _on_body_entered(body: Node2D) -> void:
	if utils.get_component(body, "InputComponent") and not played:
		if dialogue_audio and dialogue_texts.size() > 0:
			%DialogueManager.dialogue_player.volume_db = dialogue_volume
			played = true
			%DialogueManager.play_dialogue(dialogue_audio, dialogue_texts, audio_bus)
