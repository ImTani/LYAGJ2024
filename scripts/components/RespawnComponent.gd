extends Node
class_name RespawnComponent

@export_subgroup("Settings")
@export var body: CharacterBody2D
@export var respawn_time: float = 1.0

var respawn_point: Vector2 = Vector2.ZERO
var respawn_timer: Timer

func _ready() -> void:
	initialize_respawn_timer()

func respawn() -> void:
	pass

func initialize_respawn_timer() -> void:
	respawn_timer = utils._initialize_timer("RespawnTimer", respawn_time)
	add_child(respawn_timer)
