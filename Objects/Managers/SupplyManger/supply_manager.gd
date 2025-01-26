extends Node
class_name SupplyManager

@export var timer: LevelTimer 
signal updateLabel

var totalSupply: int = 0

func _ready():
	assert(timer != null)
	timer.updateSupply.connect(_on_updateSupply)

func _on_updateSupply():
	var curSupply: int = 0
	var suppliers = get_tree().get_nodes_in_group("Supplier")
	for s in suppliers:
		curSupply += s.getSupply()
	totalSupply = curSupply
	updateLabel.emit()	
	
