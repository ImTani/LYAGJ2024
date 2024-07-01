extends Node
class_name ThrowerComponent

signal item_thrown

@export var throwing_force: float = 100

var item_to_throw: Item

func handle_item_throw(item: Item, want_to_throw: bool) -> void:
	if item:
		item_to_throw = item # Handled this way to make Drop Item On Death work.
		if want_to_throw:
			throw_item()

func throw_item() -> void:
	if item_to_throw:
		
		var item_position: Vector2 = item_to_throw.global_position
		item_to_throw.get_parent().remove_child.call_deferred(item_to_throw)

		item_thrown.emit()
		item_to_throw.held = false
		
		utils._add_platformer_world_tilemap_child(item_to_throw)
		item_to_throw.set_global_position.call_deferred(item_position)
 
