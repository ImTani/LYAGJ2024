extends Node


func _add_platformer_world_tilemap_child(child) -> void:
	get_tree().get_root().get_node("/root/PlatformerWorld/Tilemap/Foreground").add_child.call_deferred(child)
