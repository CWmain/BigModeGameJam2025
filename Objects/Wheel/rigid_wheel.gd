extends RigidBody2D

@onready var handle_physics = $HandlePhysics

@export var powerPerTurn : int = 50

## When this power is exceeded triggers a break
@export var maxPower : int = 300
@export var supplyMult: int = 20
var canHold: bool = false

var SUPPLY : int = 0
var broken: bool = false

@onready var sparks = $Sparks

## Bool to prevent double adding when passing 2 Pi rotation
var canSupplyAgain: bool = true

@onready var break_sound = $BreakSound
@onready var spark_sound = $SparkSound

func _physics_process(_delta):
	if broken:
		return
	if canHold and Input.is_action_pressed("Hold"):
		var directionToMouse : Vector2 = to_global(position).direction_to(get_viewport().get_mouse_position())
		var distanceToMouse : float = to_global(position).distance_to(get_viewport().get_mouse_position())
		# Use distanceToMouse so the futher the coal is the faster it moves towards the mouse
		# And the closer it is the slower it moves 
		handle_physics.apply_force(directionToMouse*distanceToMouse*20)
		
	if Input.is_action_just_released("Hold"):
		canHold = false

	SUPPLY = max(SUPPLY, abs(int(angular_velocity))*supplyMult)
	
	if SUPPLY > maxPower - 100:
		sparks.emitting = true
		if !spark_sound.playing:
			spark_sound.play()
	else:
		sparks.emitting = false
		spark_sound.stop()
	
	# If overworked breaks
	if SUPPLY > maxPower:
		fallOff()

func _on_handle_physics_mouse_entered():
	canHold = true

func _on_handle_physics_mouse_exited():
	if !Input.is_action_pressed("Hold"):
		canHold = false

func getSupply() -> int:
	if broken:
		return 0
	var toReturn = SUPPLY
	SUPPLY = 0
	return toReturn

func fallOff() -> void:
	print("Wheel fell off")
	break_sound.play()
	broken = true
	SUPPLY = 0
	canHold = false
	handle_physics.queue_free()
	freeze = false
	apply_impulse(Vector2(200,0))

