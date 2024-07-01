extends Node2D
class_name Item

signal broken

@export var sprite: Sprite2D

var held: bool = false
var is_inside_wall: bool = false
var is_in_abyss: bool = false

func _break() -> void:
	broken.emit()
	queue_free()

func _process(delta: float) -> void:
	if is_inside_wall:
		move_out_of_wall()
	if global_position.y > 100:
		is_in_abyss = true
	
	if is_in_abyss:
		escape_abyss(delta)

func escape_abyss(delta: float) -> void:
	global_position.y -= 100 * delta
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if not held and body is TileMapLayer:
		is_inside_wall = true

func move_out_of_wall() -> void:
	global_position += Vector2(.1, -.1)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is TileMapLayer:
		if not held:
			is_inside_wall = false
		if is_in_abyss:
			is_in_abyss = false
