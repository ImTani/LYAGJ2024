extends CharacterBody2D

@export_subgroup("Components")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent
@export var animation_component: AnimationComponent
@export var holder_component: HolderComponent
@export var thrower_component: ThrowerComponent

func _ready() -> void:
	thrower_component.item_thrown.connect(holder_component.remove_current_item)

func _physics_process(delta: float) -> void:

	var horizontal_input = input_component.input_horizontal 

	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, horizontal_input)
	holder_component.handle_hold_location_update(horizontal_input)
	thrower_component.handle_item_throw(holder_component.current_item, input_component.get_mouse_click(), input_component.get_mouse_position())
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	animation_component.handle_move_animation(horizontal_input, velocity, is_on_floor())
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling, gravity_component.just_landed)

	move_and_slide()
