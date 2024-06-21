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
		
		if move_direction > 0:
			hold_location.position.x = -x_offset
			current_item.sprite.flip_h = false
		else:
			hold_location.position.x = x_offset
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
