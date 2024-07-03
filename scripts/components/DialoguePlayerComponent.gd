extends Node
class_name DialoguePlayerComponent

@export var dialogue_audio: AudioStream
@export var dialogue_texts: Dictionary
@export var dialogue_volume: float = -15
@export_enum("Voice Protagonist", "Voice Antagonist") var audio_bus: String

func play_dialogue() -> void:
	if dialogue_audio and dialogue_texts.size() > 0:
		utils.dialogue_manager.dialogue_player.volume_db = dialogue_volume
		utils.dialogue_manager.play_dialogue(dialogue_audio, dialogue_texts, audio_bus)
