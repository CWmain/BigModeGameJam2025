extends Node2D

var canHold: bool = false
@onready var coolant_handle = $CoolantHandle

var percentCoolant: float

func _ready():
	updatePercentCoolant()

func _process(_delta):
	if (canHold and Input.is_action_pressed("Hold")):
		coolant_handle.position.y = clampf(to_local(get_viewport().get_mouse_position()).y, -60, 60)
		
		#Only update percent coolant when moved
		updatePercentCoolant()
		
## Function to calculate the percentage up the handle is
func updatePercentCoolant():
	percentCoolant = 1 - (coolant_handle.position.y + 60)/120

func _on_area_2d_mouse_entered():
	canHold = true


func _on_area_2d_mouse_exited():
	if !Input.is_action_pressed("Hold"):
		canHold = false
