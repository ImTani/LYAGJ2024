extends Node
class_name HealthComponent

@export var max_health: int = 3

var health: int
var is_alive: bool = true

signal died

func _ready() -> void:
	health = max_health

func handle_health() -> void:
	health = clamp(health, 0, max_health)

func take_damage(damage: float) -> void:
	health -= damage
	if health == 0:
		die()

func heal_health(healing: float) -> void:
	health += healing

func die() -> void:
	is_alive = false
	emit_signal("died")
