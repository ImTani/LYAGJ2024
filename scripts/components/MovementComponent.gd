extends Node
class_name MovementComponent

@export_subgroup("Settings")
@export var speed: float = 100.0
@export var ground_acceleration: float = 6.0
@export var ground_deceleration: float = 8.0
@export var air_acceleration: float = 10.0
@export var air_deceleration: float = 3.0

func handle_horizontal_movement(body: CharacterBody2D, direction: float, is_dead: bool) -> void:

	if is_dead:
		body.velocity.x = 0
	else:
		var velocity_change_speed: float = 0.0
		
		if body.is_on_floor():
			velocity_change_speed = ground_acceleration if direction != 0 else ground_deceleration
		else:
			velocity_change_speed = air_acceleration if direction != 0 else air_deceleration

		body.velocity.x = move_toward(body.velocity.x, direction * speed, velocity_change_speed)
