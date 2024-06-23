extends Node
class_name HealthComponent

@export_subgroup("Settings")
@export var max_health: int = 3
@export var invincibility_time: float = 0.05

var health: int
var is_alive: bool = true
var is_invincible: bool = false
var invincibility_timer: Timer

signal died

func _ready() -> void:
	health = max_health
	initialize_invincibility_timer()

func handle_health() -> void:
	health = clamp(health, 0, max_health)

func take_damage(damage: float) -> void:
	if not is_invincible:
		health -= damage
		
		if health == 0:
			die()
			return
		
		is_invincible = true
		
		invincibility_timer.start()
		await invincibility_timer.timeout
		
		is_invincible = false


func heal_health(healing: float) -> void:
	health += healing

func die() -> void:
	is_alive = false
	emit_signal("died")

func initialize_invincibility_timer() -> void:
	invincibility_timer = utils._initialize_timer("InvincibilityTimer", invincibility_time)
	add_child(invincibility_timer)
