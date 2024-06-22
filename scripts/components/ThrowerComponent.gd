extends Node
class_name ThrowerComponent

signal item_thrown

@export var throwing_force: float = 100

func handle_item_throw(item: Item, want_to_throw: bool, target_position: Vector2) -> void:
	if item and want_to_throw:
		var item_position = item.global_position
		item.get_parent().remove_child.call_deferred(item)

		item_thrown.emit()
		
		item.set_global_position.call_deferred(item_position)
		utils._add_platformer_world_tilemap_child(item)
