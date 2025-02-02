extends Node
class_name Manager

@export var timer: LevelTimer 
## Seed for all randomness in game
@export var rSeed = 0
var random: RandomNumberGenerator
signal updateLabel

@export var saveFileString: String = "user://save_game.txt"

var totalSupply: int = 0
var totalDemand: int = 0

var supplyUpdated: bool = false
var demandUpdated: bool = false

var demandList: Array[House]

@onready var game_over_screen = $"../GameOverScreen"
@onready var pause_screen = $"../PauseScreen"

@export_category("Demand")
@export var ticksUntilDemandChange: int = 5
@export var sizeOfDemandChange: int = 2

@export_category("Loss Condition")
## The number of ticks where supply or demand remains unmet in a row
## resulting is a loss
@export var ticksUntilLoss: int = 10
## The largest value demand and supply can differ both the fail state starts counting
@export var maxSupplyDemandDiff: int = 100
var tickStreak: int = 0

var overSupply: bool = false
var overDemand: bool = false

var isGameOver: bool = false

@onready var house_toggle = $HouseToggle

func _ready():
	assert(timer != null)
	random = RandomNumberGenerator.new()
	random.seed = rSeed
	
	timer.updateSupply.connect(_on_updateSupply)
	timer.updateDemand.connect(_on_updateDemand)

func _process(_delta):
	if Input.is_action_just_pressed("Fail_Button"):
		gameLoss()
	
	if Input.is_action_just_pressed("Escape") and !isGameOver:
		pause_screen.reveal()
	
	if Input.is_action_just_pressed("Test_Click"):
		toggleAllHouses()
	
	# Once both supply and demand have been updated in the current tick
	if (supplyUpdated and demandUpdated):
		supplyUpdated = false
		demandUpdated = false
		
		overSupply = totalSupply > totalDemand + maxSupplyDemandDiff
		overDemand = totalDemand > totalSupply + maxSupplyDemandDiff  
		if overSupply or overDemand:
			tickStreak += 1
		else:
			tickStreak = 0
		
		if tickStreak == ticksUntilLoss:
			gameLoss()
		
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
	if timer.tickCount % ticksUntilDemandChange == 0:
		for i in range(0,sizeOfDemandChange):
			var rIndex = int(random.randf()*100) % demandList.size()
			demandList[rIndex].isDemanding = !demandList[rIndex].isDemanding
		house_toggle.play()
	
	# Get the current demand
	var curDemand: int = 0
	var demanaders = get_tree().get_nodes_in_group("Demander")
	for d: House in demanaders:
		if (d.isDemanding):
			curDemand += d.DEMAND
	totalDemand = curDemand
	demandUpdated = true

func gameLoss():
	print("\nGAME OVER\n")
	isGameOver = true
	game_over_screen.reveal()
	# Save highscore is better than top 10
	saveScore()
	timer.stop()

func saveScore():
	var file = FileAccess.open("user://save_game.txt", FileAccess.READ)
	var stringFile: String
	if (FileAccess.file_exists(saveFileString)):
		file = FileAccess.open("user://save_game.txt", FileAccess.READ)
		stringFile = file.get_as_text()
		file.close()
	
	# Get the highscore list
	var highScores: Array[int]
	if (stringFile.length() == 0):
		highScores = [timer.tickCount]
	else:
		highScores = str_to_var(stringFile)
		highScores.append(timer.tickCount)
	
	# Re-sort highscore list
	highScores.sort()
	
	# Ensure only 10 Highscores are stored
	if (highScores.size() > 10):
		highScores.pop_front()
	
	# Save highscore list to file
	file = FileAccess.open("user://save_game.txt", FileAccess.WRITE)
	file.store_line(var_to_str(highScores))
	file.close()


func _on_pause_button_pause_game():
	pause_screen.reveal()
