extends Node2D

@onready var wheel_handle = $WheelHandle

func _process(delta):
	rotation = position.angle_to(get_viewport().get_mouse_position())

func _on_wheel_handle_hit_box_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:

		print("On Handle")
	pass # Replace with function body.
