extends Node
class_name AudioComponent

@export var footsteps_audio_player: AudioStreamPlayer2D
@export var jump_audio_player: AudioStreamPlayer2D
@export var death_audio_player: AudioStreamPlayer2D
@export var respawn_audio_player: AudioStreamPlayer2D
@export var fall_audio_player: AudioStreamPlayer2D
@export var landing_audio_player: AudioStreamPlayer2D
@export var hurt_audio_player: AudioStreamPlayer2D
@export var stab_audio_player: AudioStreamPlayer2D

var master_bus = AudioServer.get_bus_index("Master")

func _ready() -> void:
	var audio_tween = create_tween()
	audio_tween.tween_method(change_audio_bus_volume, -80, 0, 0.5)

func change_audio_bus_volume(value: float):
	AudioServer.set_bus_volume_db(master_bus, value)

func handle_audio_playback(move_input: float, is_falling: bool) -> void:
	handle_footsteps_sfx(move_input)
	handle_falling_sfx(is_falling)
	#handle_jump_sfx()
	#handle_death_sfx()
	#handle_respawn_sfx()
	
func handle_footsteps_sfx(move_input: float) -> void:
	if move_input != 0 and not footsteps_audio_player.playing:
		footsteps_audio_player.play()
	
func handle_falling_sfx(is_falling: bool) -> void:
	if is_falling and not footsteps_audio_player.playing:
		fall_audio_player.play()
	elif not is_falling:
		fall_audio_player.stop()

func handle_jumping_sfx(is_jumping: bool) -> void:
	if is_jumping and not jump_audio_player.playing:
		jump_audio_player.play()

func handle_landing_sfx(has_just_landed: bool) -> void:
	if has_just_landed and not landing_audio_player.playing:
		landing_audio_player.play()

func handle_hurt_sfx(is_hurt: bool) -> void:
	if is_hurt and not hurt_audio_player.playing and not stab_audio_player.playing:
		stab_audio_player.play()
		hurt_audio_player.play()
		
func handle_death_sfx() -> void:
	if not death_audio_player.playing:
		death_audio_player.play()

func handle_respawn_sfx() -> void:
	if not respawn_audio_player.playing:
		respawn_audio_player.play()
