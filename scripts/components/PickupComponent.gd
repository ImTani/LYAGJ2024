extends Node
class_name PickupComponent

@export_subgroup("Settings")
@export var detection_area: Area2D
@export var item: Item

func _ready() -> void:
	detection_area.body_entered.connect(_on_pickup)

func _on_pickup(body: Node2D) -> void:
	var holder_component: HolderComponent = utils.get_component(body, "HolderComponent")
	
	if not holder_component:
		return
	
	holder_component.pick_up(item)
