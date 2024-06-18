extends Node
class_name PickupComponent

@export_subgroup("Settings")
@export var sprite: AnimatedSprite2D
@export var detection_area: Area2D
@export var item: Node2D

func _ready() -> void:
	detection_area.body_entered.connect(_on_pickup)

func _on_pickup(body) -> void:
	if not body.has_node("HolderComponent"):
		return
	body.holder_component.pick_up(item)
	item.queue_free()
