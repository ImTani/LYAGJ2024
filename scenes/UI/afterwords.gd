extends Control

@export_file("*.tscn") var credits_scene: String

@onready var scroll_container: ScrollContainer = $Control/CreditFor/VBoxContainer/ScrollContainer
@onready var afterword: Control = $"."
@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	scroll_container.scroll_vertical += 1
	if scroll_container.scroll_vertical == 274:
		timer.stop()
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file(credits_scene)
