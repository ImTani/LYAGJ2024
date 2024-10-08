extends Node2D

@export_subgroup("Settings")
@export var animation_player: AnimationPlayer
@export var rise_animation: StringName = "rise"

func _on_checkpoint_entered(body: Node2D) -> void:

	var respawn_component: RespawnComponent = utils.get_component(body, "RespawnComponent") 
	
	if not respawn_component:
		return
	
	respawn_component.respawn_point = global_position
	utils.last_checkpoint = global_position
	
	if animation_player.current_animation:
		animation_player.play(rise_animation)
		$FlagWave.play()
		await $FlagWave.finished

	set_process_mode.call_deferred(PROCESS_MODE_DISABLED)
