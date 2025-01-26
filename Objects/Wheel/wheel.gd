extends Node2D

@onready var wheel_handle = $WheelHandle

var canHold: bool = false
var oldRotation: float = -1

var SUPPLY : int = 10
signal supplyPower(supply: int)
var canSupplyAgain: bool = true

func _process(_delta):
	if canHold and Input.is_action_pressed("Hold"):
		var newRotation : float = PI + position.direction_to(get_viewport().get_mouse_position()).angle()
		if oldRotation > 2*PI-0.1 and oldRotation < 2*PI+0.1:
			oldRotation = 0
		
		if newRotation > oldRotation:
			rotation = newRotation
			oldRotation = newRotation
		
	if Input.is_action_just_released("Hold"):
		canHold = false

	# Since we are in process, use a bool to ensure the emit only triggers once
	if rotation > PI-0.1 and rotation < PI+0.1 and canSupplyAgain:
		canSupplyAgain = false
		supplyPower.emit(SUPPLY)
	
	# Once the otherside is reached, allow another supply trigger to occur
	if rotation > (2*PI)-0.1 and rotation < (2*PI)+0.1:
		canSupplyAgain = true

func _on_wheel_handle_hit_box_mouse_entered():
	canHold = true


