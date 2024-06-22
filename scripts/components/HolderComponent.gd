extends Node
class_name HolderComponent

@export_subgroup("Settings")
@export var hold_location: Node2D
@export var x_offset: float

var current_item: Item = null

func handle_hold_location_update(move_direction: float) -> void:
	
	if current_item:
		if move_direction == 0:
			return
		
		var position_tween = create_tween()
		position_tween.set_ease(Tween.EASE_IN_OUT)
		
		if move_direction > 0:
			position_tween.tween_property(hold_location, "position", Vector2(-x_offset, 0), 0.2)
			current_item.sprite.flip_h = false
		else:
			position_tween.tween_property(hold_location, "position", Vector2(x_offset, 0), 0.2)
			current_item.sprite.flip_h = true

func pick_up(item: Item) -> void:
	if current_item:
		return
	hold_item(item)

func hold_item(item: Item) -> void:
	item.get_parent().remove_child.call_deferred(item)
	item.position = Vector2.ZERO
	current_item = item
	hold_location.add_child.call_deferred(item)

func remove_current_item() -> void:
	current_item = null
