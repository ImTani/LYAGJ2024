extends Node
class_name HeartUIManagerComponent

@export var hearts_container: Control
@export var heart_texture_scene: PackedScene
@export var player: Player

var heart_count: int
var _heart_count: int

var alpha_tween: Tween

func _ready() -> void:
	heart_count = player.health_component.max_health
	_heart_count = heart_count

	player.health_component.hurt.connect(_remove_heart)
	player.respawn_component.respawned.connect(_reset_hearts)
	
	run_alpha_tween()

func _remove_heart(damage: int) -> void:

	run_alpha_tween()
	
	if _heart_count > 0:
		if damage > _heart_count:
			for child in hearts_container.get_children(): child.queue_free()
		else:
			for i: int in range(damage):
				hearts_container.get_child(-1).queue_free()
				_heart_count -= 1

func run_alpha_tween() -> void:

	hearts_container.get_parent().modulate.a = 1
	hearts_container.get_parent().visible = true	

	if alpha_tween:
		alpha_tween.kill()
	
	alpha_tween = create_tween()
	alpha_tween.set_ease(Tween.EASE_IN)
	
	alpha_tween.tween_property(hearts_container.get_parent(), "modulate:a", 0, 3)

func _reset_hearts() -> void:
	for child in hearts_container.get_children():
		child.queue_free()
	_heart_count = heart_count
	for i in range(heart_count):
		hearts_container.add_child(heart_texture_scene.instantiate())
