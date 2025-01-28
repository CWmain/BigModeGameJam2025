extends Node
class_name Manager

@export var timer: LevelTimer 
signal updateLabel

var totalSupply: int = 0
var totalDemand: int = 0

var supplyUpdated: bool = false
var demandUpdated: bool = false

var demandList: Array[House]

## Seed for all randomness in game
@export var rSeed = 0
var random: RandomNumberGenerator

func _ready():
	assert(timer != null)
	random = RandomNumberGenerator.new()
	random.seed = rSeed
	
	timer.updateSupply.connect(_on_updateSupply)
	timer.updateDemand.connect(_on_updateDemand)

func _process(_delta):
	if Input.is_action_just_pressed("Test_Click"):
		toggleAllHouses()
		
	if (supplyUpdated and demandUpdated):
		supplyUpdated = false
		demandUpdated = false
		updateLabel.emit()	

## Test function to ensure all homes toggle correctly
func toggleAllHouses():
	var demanaders = get_tree().get_nodes_in_group("Demander")
	for d: House in demanaders:
		d.isDemanding = !(d.isDemanding)

func _on_updateSupply():
	var curSupply: int = 0
	var suppliers = get_tree().get_nodes_in_group("Supplier")
	for s in suppliers:
		curSupply += s.getSupply()
	totalSupply = curSupply
	supplyUpdated = true

func _on_updateDemand():
	# Toggle a random house
	var rIndex = int(random.randf()*100) % demandList.size()
	demandList[rIndex].isDemanding = !demandList[rIndex].isDemanding
	
	# Get the current demand
	var curDemand: int = 0
	var demanaders = get_tree().get_nodes_in_group("Demander")
	for d: House in demanaders:
		if (d.isDemanding):
			curDemand += d.DEMAND
	totalDemand = curDemand
	demandUpdated = true
