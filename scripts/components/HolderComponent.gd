extends Node
class_name HolderComponent

@export_subgroup("Settings")
@export var HoldLocation: Node2D

var current_item = null

func pick_up(item) -> void:
	print("picked up item ", item.name)
	if not current_item:
		current_item = item
	else:
		drop_item(current_item)
		current_item = item

func drop_item(item) -> void:
	print("dropped ", item)
	current_item = null
	item.queue_free()
