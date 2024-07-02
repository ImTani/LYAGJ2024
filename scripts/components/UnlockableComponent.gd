extends Node
class_name UnlockableComponent

@export_subgroup("Settings")
@export var neighbour_detection_area: Area2D
@export var door: Door
@export var break_sound: AudioStreamPlayer2D
@export var break_particles: CPUParticles2D
@export var base_delay_time: float = 0.5

var neighbouring_unlockables: Array[Door]
var is_unlocked: bool = false

func _on_detector_area_entered(area: Area2D) -> void:
	var body: Node2D = area.get_parent()
	var key_component: KeyComponent = utils.get_component(body, "KeyComponent")
	
	if not key_component:
		return
	
	_unlock()
	key_component.key._break()

func _unlock() -> void:
	if is_unlocked: 
		return
	is_unlocked = true

	_break()
	_unlock_neighbours_with_delay(base_delay_time)

func _unlock_neighbours_with_delay(initial_delay: float) -> void:
	if neighbouring_unlockables.size() == 0:
		return
	
	var delay_increment: float = initial_delay
	
	for neighbour: Door in neighbouring_unlockables:
		if neighbour and not neighbour.unlockable_component.is_unlocked:
			neighbour.unlockable_component.unlock_with_delay(delay_increment)
			delay_increment += base_delay_time

func unlock_with_delay(delay: float) -> void:
	await get_tree().create_timer(delay).timeout
	_unlock()

func _on_neighbour_detection_area_area_entered(area: Area2D) -> void:
	var body: Node2D = area.get_parent()
	var unlockable_component: UnlockableComponent = utils.get_component(body, "UnlockableComponent")
	if unlockable_component:
		neighbouring_unlockables.append(body)

func _break() -> void:
	break_sound.play()
	break_particles.emitting = true
	door.collision_shape.set_disabled.call_deferred(true)
	door.visible = false
	await break_sound.finished
	door.queue_free()
