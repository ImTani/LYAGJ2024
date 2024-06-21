extends Node
class_name ThrowerComponent

signal item_thrown

@export var throwing_force: float = 100

func handle_item_throw(item: Item, want_to_throw: bool, target_position: Vector2) -> void:
	if item and want_to_throw:
		print("Starting to drop %s, current global_position is %v" % [item.name, item.global_position])
		
		var item_position = item.global_position
		item.get_parent().remove_child.call_deferred(item)
		
		print("%s removed from its parent. Current global_position is %v" % [item.name, item.global_position])
		
		item_thrown.emit()
		
		item.global_position = item_position	
		#utils._add_platformer_world_tilemap_child(item)
		get_tree().get_root().add_child.call_deferred(item)

		print("%s dropped. Current global_position is %v" % [item.name, item.global_position])
