extends Node
class_name DialogueManager

@onready var subtitles: Label = get_node("/root/PlatformerWorld/UI/Theme/Subtitles/MarginContainer/SubtitleLabel")
@onready var dialogue_player: AudioStreamPlayer2D = get_node("/root/PlatformerWorld/Player/Dialogues")

func play_dialogue(audio: AudioStream, subtitle: String) -> void:
	dialogue_player.stream = audio
	dialogue_player.play()
	subtitles.text = subtitle
	await dialogue_player.finished
	subtitles.text = ""
