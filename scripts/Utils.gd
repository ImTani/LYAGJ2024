extends Node

@onready var platformer_tile_map_foreground: TileMapLayer = get_tree().get_root().get_node("/root/PlatformerWorld/Tilemap/Foreground")

func _add_root_child(child) -> void:
	get_tree().get_root().add_child.call_deferred(child)

func _add_platformer_world_tilemap_child(child) -> void:
	get_tree().get_root().get_node("/root/PlatformerWorld/Tilemap/Foreground").add_child.call_deferred(child)

func get_component(parent: Node, component: String):
	if parent.has_node(component):
		return parent.get_node(component)
	else:
		return null
