extends Node
class_name InputComponent

@export_subgroup("Settings")
@export var left_input: StringName = "move_left"
@export var right_input: StringName = "move_right"
@export var jump_input: StringName = "jump"

var input_horizontal: float = 0.0

func _process(delta: float) -> void:
	input_horizontal = Input.get_axis(left_input, right_input)

func get_jump_input() -> bool:
	return Input.is_action_just_pressed(jump_input) 

func get_jump_input_released() -> bool:
	return Input.is_action_just_released(jump_input) 

func get_mouse_position() -> Vector2:
	return get_viewport().get_mouse_position()

func get_mouse_click() -> bool:
	return Input.is_action_just_pressed("click")
