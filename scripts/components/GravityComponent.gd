extends Node
class_name GravityComponent

@export_subgroup("Settings")
@export var gravity: float = 9.8

var is_falling: bool = false
var just_landed: bool = false

func handle_gravity(body: CharacterBody2D, delta: float):

	if not body.is_on_floor():
		body.velocity.y += gravity * delta

	is_falling = body.velocity.y > 0 and not body.is_on_floor()
