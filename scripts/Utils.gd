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

func _initialize_timer(_name: String, _wait_time: float):
	var _timer = Timer.new()
	_timer.wait_time = _wait_time
	_timer.one_shot = true
	_timer.name = _name
	return _timer
