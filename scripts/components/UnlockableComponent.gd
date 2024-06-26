extends Node
class_name UnlockableComponent

@export_subgroup("Settings")
@export var neighbour_detection_area: Area2D

var neighbouring_unlockables: Array[Node2D]

func _on_detector_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	var key_component: KeyComponent = utils.get_component(body, "KeyComponent")
	
	if not key_component:
		return
	
	print("Key Detected")
	
	#TODO Should not be able to drop keys behind tiles.

func handle_neighbouring_unlockables() -> void:
	# I want to check all 8 neighbouring tiles for oter Doors.
	pass

func unlock() -> void:
	print("Door unlocked", get_parent().name)
