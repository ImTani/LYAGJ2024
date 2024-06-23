extends Node
class_name RespawnComponent

@export_subgroup("Settings")
@export var body: CharacterBody2D
@export var respawn_time: float = 1.0
@export var respawn_particles: PackedScene

var respawn_point: Vector2 = Vector2.ZERO
var respawn_timer: Timer

func _ready() -> void:
	initialize_respawn_timer()

func respawn() -> void:
	respawn_timer.start()
	await respawn_timer.timeout

	body.global_position = respawn_point
	handle_respawn_particles()
	
	var animation_component: AnimationComponent = utils.get_component(body, "AnimationComponent")
	if animation_component:
		animation_component.handle_respawn_animation()
	
	var health_component: HealthComponent = utils.get_component(body, "HealthComponent")
	if health_component:
		health_component.is_alive = true
		health_component.health = health_component.max_health

func handle_respawn_particles() -> void:
	var _respawn_particles: CPUParticles2D = respawn_particles.instantiate()
	_respawn_particles.global_position = body.global_position
	_respawn_particles.emitting = true
	utils._add_root_child(_respawn_particles)

func initialize_respawn_timer() -> void:
	respawn_timer = utils._initialize_timer("RespawnTimer", respawn_time)
	add_child(respawn_timer)
