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
@export var audio_component: AudioComponent
@export var flame_position_flipping_component: PositionFlippingComponent

func _ready() -> void:
	thrower_component.item_thrown.connect(holder_component.remove_current_item)
	health_component.died.connect(respawn_component.respawn)
	health_component.died.connect(thrower_component.throw_item)

func _physics_process(delta: float) -> void:

	var horizontal_input = input_component.input_horizontal 
	var is_dead: bool = not health_component.is_alive
	var is_invincible: bool = health_component.is_invincible
	
	var immobile: bool = is_dead
	
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, horizontal_input, is_dead)

	if not immobile:
		holder_component.handle_hold_location_update(horizontal_input)
		flame_position_flipping_component.handle_flipping(horizontal_input)
		thrower_component.handle_item_throw(holder_component.current_item, input_component.get_mouse_click(), input_component.get_mouse_position())

		jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())

		animation_component.handle_move_animation(horizontal_input, velocity, is_on_floor())
		animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling, jump_component.has_just_landed(self))
		audio_component.handle_footsteps_sfx(horizontal_input)

	
	animation_component.handle_death_animation(is_dead)
	health_component.handle_health()

	move_and_slide()
