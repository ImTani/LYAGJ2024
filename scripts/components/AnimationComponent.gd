extends Node
class_name AnimationComponent

@export_subgroup("Nodes")
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

@export_subgroup("Settings")
@export var idle_animation: StringName = "idle"
@export var run_animation: StringName = "run"
@export var jump_animation: StringName = "jump"
@export var fall_animation: StringName = "fall"
@export var land_animation: StringName = "land"

var is_landing: bool = false

func handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0:
		return
		
	sprite.flip_h = false if move_direction > 0 else true

func handle_move_animation(move_direction: float, velocity: Vector2, on_floor: bool) -> void:
	handle_horizontal_flip(move_direction)
	
	if on_floor and not is_landing:
		if velocity:
			play_animation(run_animation)
		else:
			play_animation(idle_animation)

func handle_jump_animation(is_jumping: bool, is_falling: bool, has_landed: bool) -> void:
	if is_jumping:
		play_animation(jump_animation)

	elif is_falling:
		play_animation(fall_animation)

	elif has_landed:
		is_landing = true
		play_animation(land_animation)
		await animation_player.animation_finished
		is_landing = false

func play_animation(animation) -> void:
	if animation_player.current_animation != animation:
		animation_player.play(animation)
