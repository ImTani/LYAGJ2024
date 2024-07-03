extends Node
class_name Utils

var player: Player

var last_checkpoint: Vector2:
	set(value):
		last_checkpoint = value

func _add_root_child(child: Node2D) -> void:
	get_tree().get_root().add_child.call_deferred(child)

func _add_platformer_world_child(child: Node2D) -> void:
	get_tree().get_root().get_node("/root/PlatformerWorld").add_child.call_deferred(child)

func _add_platformer_world_tilemap_child(child: Node2D) -> void:
	get_tree().get_root().get_node("/root/PlatformerWorld/Tilemap/Foreground").add_child.call_deferred(child)

func get_component(parent: Node, component: String) -> Node:
	if parent.has_node(component):
		return parent.get_node(component)
	else:
		return null

func restart_from_last_checkpoint(game_scene: String) -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(game_scene)

	await get_tree().process_frame
	
	player.set_global_position.call_deferred(last_checkpoint)

func change_bg(audio: AudioStream) -> void:
	var audio_tween: Tween = create_tween()
	audio_tween.tween_property(BackgroundMusic, "volume_db", -50, 1)
	
	await audio_tween.finished
	
	BackgroundMusic.stream = audio
	BackgroundMusic.play()
	audio_tween.kill()
	
	audio_tween = create_tween()
	audio_tween.tween_property(BackgroundMusic, "volume_db", -5, 3)

func _initialize_timer(_name: String, _wait_time: float) -> Timer:
	var _timer: Timer = Timer.new()
	_timer.wait_time = _wait_time
	_timer.one_shot = true
	_timer.name = _name
	return _timer
