extends Node2D

@export var powerPerCoal : int = 50

## When this power is exceeded triggers a fire
@export var maxPower : int = 200
@export var powerDecreasePerTick: int = 10

var SUPPLY : int = 0


func _process(_delta):
	# If overworked breaks
	if SUPPLY > maxPower:
		bigFire()

func getSupply() -> int:
	var toReturn: int = SUPPLY
	SUPPLY -= powerDecreasePerTick
	if SUPPLY < 0:
		SUPPLY = 0
	
	return toReturn

func bigFire() -> void:
	print("Furnace combusted")
	SUPPLY = 0


func _on_collection_body_entered(body):
	if typeof(body) != typeof(Coal):
		print("Wrong type")
		return
	SUPPLY += powerPerCoal
	print("Coal Collected")
	
