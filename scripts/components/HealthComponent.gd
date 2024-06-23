extends Node
class_name HealthComponent

@export_subgroup("Settings")
@export var body: CharacterBody2D
@export var hurt_particles: PackedScene
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
		handle_hurt_particles()
		
		if health <= 0:
			die()
			return
		
		handle_invincibility()

func heal_health(healing: float) -> void:
	health += healing

func die() -> void:
	is_alive = false
	emit_signal("died")

func handle_invincibility() -> void:
	is_invincible = true
		
	invincibility_timer.start()
	await invincibility_timer.timeout
	
	is_invincible = false

func handle_hurt_particles() -> void:
	var _hurt_particles: CPUParticles2D = hurt_particles.instantiate()
	_hurt_particles.global_position = body.global_position
	_hurt_particles.emitting = true
	utils._add_root_child(_hurt_particles)

func initialize_invincibility_timer() -> void:
	invincibility_timer = utils._initialize_timer("InvincibilityTimer", invincibility_time)
	add_child(invincibility_timer)
