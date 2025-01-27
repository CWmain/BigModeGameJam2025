extends RigidBody2D
class_name Coal
var trackMouse: bool = false

@onready var grab_cooldown_timer = $grabCooldown
var grab_cooldown: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if trackMouse and Input.is_action_pressed("Hold"):
		var directionToMouse : Vector2 = position.direction_to(get_viewport().get_mouse_position())
		var distanceToMouse : float = position.distance_to(get_viewport().get_mouse_position())
		# Use distanceToMouse so the futher the coal is the faster it moves towards the mouse
		# And the closer it is the slower it moves 
		linear_velocity = directionToMouse*distanceToMouse*20

	if Input.is_action_just_released("Hold"):
		trackMouse = false
		grab_cooldown = true
		grab_cooldown_timer.start()

func _on_mouse_entered():
	if !grab_cooldown:
		trackMouse = true

func _on_mouse_exited():
	if !Input.is_action_pressed("Hold"):
		trackMouse = false

func _on_grab_cooldown_timeout():
	grab_cooldown = false

func destroy():
	print("Coal: Coal Destroyed")
	queue_free()
