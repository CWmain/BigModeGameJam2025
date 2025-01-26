extends Node
class_name DemandManager

@export var timer: LevelTimer 
signal updateLabel

var totalDemand: int = 0

func _ready():
	assert(timer != null)
	timer.updateDemand.connect(_on_updateDemand)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Test_Click"):
		toggleAllHouses()

## Test function to ensure all homes toggle correctly
func toggleAllHouses():
	var demanaders = get_tree().get_nodes_in_group("Demander")
	for d: House in demanaders:
		d.isDemanding = !(d.isDemanding)

func _on_updateDemand():
	var curDemand: int = 0
	var demanaders = get_tree().get_nodes_in_group("Demander")
	for d: House in demanaders:
		if (d.isDemanding):
			curDemand += d.DEMAND
	totalDemand = curDemand
	updateLabel.emit()	
	
