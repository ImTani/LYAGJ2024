extends Node
class_name HeartUIManagerComponent

@export var hearts_container: Control
@export var heart_texture_scene: PackedScene
@export var player: Player

var heart_count: int
var _heart_count: int

@onready var alpha_tween: Tween = create_tween()

func _ready() -> void:
	heart_count = player.health_component.max_health
	_heart_count = heart_count

	player.health_component.hurt.connect(_remove_heart)
	player.respawn_component.respawned.connect(_reset_hearts)

func _remove_heart() -> void:
	alpha_tween.kill()
	
	hearts_container.get_parent().visible = true
	
	if _heart_count > 0:
		hearts_container.get_child(-1).queue_free()
		_heart_count -= 1
	
	alpha_tween.tween_property(hearts_container.get_parent(), "modulate:a", 0, 1)
	await alpha_tween.finished
	
	hearts_container.get_parent().visible = false
	hearts_container.get_parent().modulate.a = 255

func _reset_hearts() -> void:
	for child in hearts_container.get_children():
		child.queue_free()
	_heart_count = heart_count
	for i in range(heart_count):
		hearts_container.add_child(heart_texture_scene.instantiate())
