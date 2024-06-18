extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent
@export var animation_component: AnimationComponent
@export var holder_component: HolderComponent

func _physics_process(delta: float) -> void:

	var horizontal_input = input_component.input_horizontal 

	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, horizontal_input)
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	animation_component.handle_move_animation(horizontal_input)
	animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling, gravity_component.just_landed)
	
	move_and_slide()
