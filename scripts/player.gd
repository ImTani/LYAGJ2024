extends CharacterBody2D

@export_subgroup("Components")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent
@export var animation_component: AnimationComponent
@export var holder_component: HolderComponent
@export var thrower_component: ThrowerComponent
@export var respawn_component: RespawnComponent
@export var health_component: HealthComponent

func _ready() -> void:
	thrower_component.item_thrown.connect(holder_component.remove_current_item)
	health_component.died.connect(respawn_component.respawn)

func _physics_process(delta: float) -> void:

	var horizontal_input = input_component.input_horizontal 
	var is_dead = not health_component.is_alive

	gravity_component.handle_gravity(self, delta)

	if not is_dead:
		movement_component.handle_horizontal_movement(self, horizontal_input)
		
		holder_component.handle_hold_location_update(horizontal_input)
		thrower_component.handle_item_throw(holder_component.current_item, input_component.get_mouse_click(), input_component.get_mouse_position())

		jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())

		animation_component.handle_move_animation(horizontal_input, velocity, is_on_floor())
		animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling, jump_component.has_just_landed(self))
	
	animation_component.handle_death_animation(is_dead)
	health_component.handle_health()

	move_and_slide()
