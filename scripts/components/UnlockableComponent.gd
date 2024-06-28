extends Node
class_name UnlockableComponent

@export_subgroup("Settings")
@export var neighbour_detection_area: Area2D
@export var door: Node2D

var neighbouring_unlockables: Array[Node2D]
var is_unlocked: bool = false

func _on_detector_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	var key_component: KeyComponent = utils.get_component(body, "KeyComponent")
	
	if not key_component:
		return
	
	_unlock()
	key_component.key._break()
	
	#TODO Should not be able to drop keys behind tiles.

func _unlock() -> void:
	if is_unlocked: return
	
	is_unlocked = true
	
	_break()
	
	for neighbour in neighbouring_unlockables:
		if neighbour != self and neighbour:
			neighbour.unlockable_component._unlock()

func _break() -> void:
	door.queue_free()

func _on_neighbour_detection_area_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	var unlockable_component = utils.get_component(body, "UnlockableComponent")
	if unlockable_component:
		neighbouring_unlockables.append(body)
