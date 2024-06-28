extends Node
class_name PositionFlippingComponent

@export_subgroup("Settings")
@export var object_to_flip: Node2D
@export var positive_x_offset: float = 10
@export var negative_x_offset: float = 10
@export var positive_y_offset: float = 0
@export var negative_y_offset: float = 0
@export var time_to_tween: float = 0.2


func handle_flipping(threshold_property: float):
	if threshold_property == 0:
		return
	
	var position_tween = create_tween()
	position_tween.set_ease(Tween.EASE_IN)
	
	if threshold_property > 0:
		position_tween.tween_property(object_to_flip, "position", Vector2(positive_x_offset, positive_y_offset), time_to_tween)
	else:
		position_tween.tween_property(object_to_flip, "position", Vector2(negative_x_offset, negative_y_offset), time_to_tween)
