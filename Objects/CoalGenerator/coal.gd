extends RigidBody2D
class_name Coal
var trackMouse: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if trackMouse and Input.is_action_pressed("Hold"):
		apply_force(position.direction_to(get_viewport().get_mouse_position())*position.distance_to(get_viewport().get_mouse_position())*20)
	
	if Input.is_action_just_released("Hold"):
		trackMouse = false

func _on_mouse_entered():
	trackMouse = true
