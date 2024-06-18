extends Node
class_name InputComponent

@export_subgroup("Settings")
@export var left_input: StringName = "move_left"
@export var right_input: StringName = "move_right"
@export var jump_input: StringName = "jump"

var input_horizontal: float = 0.0

func _process(delta: float) -> void:
	input_horizontal = Input.get_axis(left_input, right_input)

func get_jump_input():
	return Input.is_action_just_pressed(jump_input) 

func get_jump_input_released():
	return Input.is_action_just_released(jump_input) 
