extends Node
class_name AdvancedJumpComponent

signal jumped

@export_subgroup("Settings")
@export var jump_velocity: float = -250.0
@export var jump_buffer_time: float = 0.1
@export var coyote_time: float = 0.08

var jump_buffer_timer: Timer
var coyote_timer: Timer

var is_going_up: bool = false
var is_jumping: bool = false
var last_frame_on_floor: bool = false

func _ready() -> void:
	initialize_jump_buffer_timer() #because im too lazy to make it a scene
	initialize_coyote_timer() # x2

func has_just_landed(body: CharacterBody2D) -> bool:
	return body.is_on_floor() and not last_frame_on_floor and is_jumping

func has_just_stepped_off_ledge(body: CharacterBody2D) -> bool:
	return not body.is_on_floor() and last_frame_on_floor and not is_jumping

func is_allowed_to_jump(body: CharacterBody2D, want_to_jump: bool) -> bool:
	return want_to_jump and (body.is_on_floor() or not coyote_timer.is_stopped())

func handle_jump(body: CharacterBody2D, want_to_jump: bool, jump_released: bool) -> void:
	if has_just_landed(body):
		is_jumping = false
	
	if is_allowed_to_jump(body, want_to_jump):
		jump(body)
	
	handle_coyote_time(body)
	handle_jump_buffer(body, want_to_jump)
	handle_variable_jump_height(body, jump_released)
	
	is_going_up = body.velocity.y < 0 and not body.is_on_floor()
	last_frame_on_floor = body.is_on_floor()

func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void:
	if jump_released and is_going_up:
		body.velocity.y = 0

func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and not body.is_on_floor():
		jump_buffer_timer.start()
		
	if body.is_on_floor() and not jump_buffer_timer.is_stopped():
		jump(body)

func handle_coyote_time(body: CharacterBody2D) -> void:
	if has_just_stepped_off_ledge(body):
		coyote_timer.start()
	
	if not coyote_timer.is_stopped() and not is_jumping:
		body.velocity.y = 0

func handle_jump_pad(body: CharacterBody2D) -> void:
	jumped.emit()
	
	body.velocity.y = jump_velocity * 2.25
	is_jumping = true
	jump_buffer_timer.stop()
	coyote_timer.stop()

func jump(body: CharacterBody2D) -> void:
	jumped.emit()
	
	body.velocity.y = jump_velocity
	is_jumping = true
	jump_buffer_timer.stop()
	coyote_timer.stop()

func initialize_jump_buffer_timer() -> void:
	jump_buffer_timer = utils._initialize_timer("JumpBufferTimer", jump_buffer_time)
	add_child(jump_buffer_timer)

func initialize_coyote_timer() -> void:
	coyote_timer = utils._initialize_timer("CoyoteTimer", coyote_time)
	add_child(coyote_timer)
