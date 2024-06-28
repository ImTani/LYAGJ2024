extends Area2D

@export var dialogue_audio: AudioStream
@export var dialogue_text: String
@export var dialogue_volume: float = -15

var played: bool = false

func _on_body_entered(body: Node2D) -> void:
	if utils.get_component(body, "InputComponent") and not played:
		if dialogue_audio and dialogue_text:
			DialogManager.dialogue_player.volume_db = dialogue_volume
			played = true
			DialogManager.play_dialogue(dialogue_audio, dialogue_text)
