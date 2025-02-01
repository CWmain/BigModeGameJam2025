extends Node2D



@onready var coolant_controls = $CoolantControls
@onready var power_gauge = $PowerGauge

@export var maxPower: int = 1000
@export var addedPower: int = 100
## When the coolent is maxed, SUPPLY is reduced by below amount
@export var subtractedPower: int = 1000

var SUPPLY: int = 0:
	set(value):
		SUPPLY = max(0, value)

var getSupplyCount: int = 0

func _process(_delta):
	if SUPPLY > maxPower:
		power_gauge.breakGauge()
		return
	power_gauge.setGauge(float(SUPPLY)/float(maxPower))

func getSupply()->int:
	if getSupplyCount % 2 == 0:
		SUPPLY = addedPower + (SUPPLY*2)
		SUPPLY -= int(subtractedPower*coolant_controls.percentCoolant)
	getSupplyCount += 1
	return SUPPLY
