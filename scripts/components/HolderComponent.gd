extends Node
class_name HolderComponent

@export_subgroup("Settings")
@export var holder_position_flipping_component: PositionFlippingComponent
@export var hold_location: Node2D

var current_item: Item = null

func handle_hold_location_update(move_direction: float) -> void:
	
	holder_position_flipping_component.handle_flipping(move_direction)
	
	if current_item:
		if move_direction == 0:
			return
		
		if move_direction > 0:
			current_item.sprite.flip_h = false
		else:
			current_item.sprite.flip_h = true

func pick_up(item: Item) -> void:
	if current_item:
		return
	hold_item(item)

func hold_item(item: Item) -> void:
	var item_pos = item.global_position
	item.get_parent().remove_child.call_deferred(item)
	
	current_item = item
	
	hold_location.add_child.call_deferred(item)
	
	item.held = true
	item.broken.connect(remove_current_item)
	
	item.set_global_position.call_deferred(item_pos)
	
	var pos_tween = create_tween()
	pos_tween.tween_property.call_deferred(item, "position", Vector2.ZERO, 0.2)

func remove_current_item() -> void:
	current_item = null
