extends Node
class_name DialogueManager

@onready var subtitles: Label = %SubtitleLabel
@onready var dialogue_player: AudioStreamPlayer2D = %DialoguePlayer

func play_dialogue(audio: AudioStream, subtitles_dict: Dictionary, audio_bus: String) -> void:
	dialogue_player.bus = audio_bus
	dialogue_player.stream = audio
	dialogue_player.play()
	
	var keys: Array = subtitles_dict.keys()
	keys.sort()
	
	var subtitle_update_interval: float = 0.1  # Update interval in seconds
	
	while dialogue_player.playing:
		var current_position: float = dialogue_player.get_playback_position()
		
		for key: float in keys:
			if current_position >= key:
				subtitles.text = subtitles_dict[key]
			else:
				break
		
		await get_tree().create_timer(subtitle_update_interval).timeout
	
	await get_tree().create_timer(subtitle_update_interval).timeout
	subtitles.text = ""
