extends Node2D
class_name Item

signal broken

@export_subgroup("Settings")
@export var sprite: Sprite2D
@export var abyss_y_position: float = 100
@export var minimum_distance_from_player: float = 18

var held: bool = false
var is_inside_wall: bool = false
var is_in_abyss: bool = false

func _break() -> void:
	broken.emit()
	queue_free()


func _process(delta: float) -> void:
	
	if held:
		is_inside_wall = false
		is_in_abyss = false
	
	if is_inside_wall:
		move_out_of_wall()

	if global_position.y > abyss_y_position:
		is_in_abyss = true
	
	if is_in_abyss:
		move_towards_player(100)

func move_towards_player(speed: float) -> void:
	if not utils.player:
		return
	
	if not utils.player.global_position.distance_to(global_position) > minimum_distance_from_player:
		is_in_abyss = false
		return

	var delta: float = get_process_delta_time()
	var direction: Vector2 = global_position.direction_to(utils.player.global_position)
	global_position += speed * delta * direction
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		is_inside_wall = true

func move_out_of_wall() -> void:
	move_towards_player(10)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is TileMapLayer:
		is_inside_wall = false
