extends Node
class_name HurtComponent

@export_subgroup("Settings")
@export var hurtbox: Area2D
@export var damage: int

func _on_hurt_box_entered(body: Node2D) -> void:
	var health_component: HealthComponent = utils.get_component(body, "HealthComponent")
	
	if not health_component:
		return
	
	health_component.take_damage(damage)
