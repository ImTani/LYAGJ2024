extends Node
class_name AudioComponent

@export var footsteps_audio_player: AudioStreamPlayer2D
@export var jump_audio_player: AudioStreamPlayer2D
@export var death_audio_player: AudioStreamPlayer2D
@export var respawn_audio_player: AudioStreamPlayer2D

func handle_audio_playback(move_input: float) -> void:
	handle_footsteps_sfx(move_input)
	#handle_jump_sfx()
	#handle_death_sfx()
	#handle_respawn_sfx()
	
func handle_footsteps_sfx(move_input: float) -> void:
	if move_input != 0 and not footsteps_audio_player.playing:
		footsteps_audio_player.play()
