extends RigidBody2D

@onready var handle_physics = $HandlePhysics

@export var powerPerTurn : int = 50

## When this power is exceeded triggers a break
@export var maxPower : int = 300

var canHold: bool = false

## Used to prevent spinning the wheel the wrong way
var oldRotation: float = -1

var SUPPLY : int = 0
var broken: bool = false

## Bool to prevent double adding when passing 2 Pi rotation
var canSupplyAgain: bool = true

func _physics_process(_delta):
	if canHold and Input.is_action_pressed("Hold"):
		var directionToMouse : Vector2 = to_global(position).direction_to(get_viewport().get_mouse_position())
		var distanceToMouse : float = to_global(position).distance_to(get_viewport().get_mouse_position())
		# Use distanceToMouse so the futher the coal is the faster it moves towards the mouse
		# And the closer it is the slower it moves 
		handle_physics.apply_force(directionToMouse*distanceToMouse*20)
		
	if Input.is_action_just_released("Hold"):
		canHold = false

	# Since we are in process, use a bool to ensure the emit only triggers once
	if rotation > PI/2.0 and canSupplyAgain:
		canSupplyAgain = false
		SUPPLY += powerPerTurn
	
	# Once the otherside is reached, allow another supply trigger to occur
	if rotation < -(PI/2.0):
		canSupplyAgain = true
		
	# If overworked breaks
	if SUPPLY > maxPower:
		fallOff()

func _on_handle_physics_mouse_entered():
	canHold = true

func getSupply() -> int:
	if broken:
		return 0
		
	var toReturn: int = SUPPLY
	SUPPLY = 0
	return toReturn

func fallOff() -> void:
	print("Wheel fell off")
	broken = true
	SUPPLY = 0
	canHold = false
	handle_physics.queue_free()
	freeze = false
	apply_impulse(Vector2(200,0))

