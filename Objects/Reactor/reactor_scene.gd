extends Node2D



@onready var coolant_controls = $CoolantControls
@onready var power_gauge = $PowerGauge

@export var maxPower: int = 1000
@export var addedPower: int = 100
## When the coolent is maxed, SUPPLY is reduced by below amount
@export var subtractedPower: int = 1000

var broken: bool = false

var SUPPLY: int = 0:
	set(value):
		SUPPLY = max(0, value)

var getSupplyCount: int = 0

func _process(_delta):
	if SUPPLY > maxPower and !broken:
		power_gauge.breakGauge()
		broken = true

	power_gauge.setGauge(clampf(float(SUPPLY)/float(maxPower),0,1))

func getSupply()->int:
	if broken:
		return 0
	if getSupplyCount % 2 == 0:
		SUPPLY = addedPower + (SUPPLY*2)
		SUPPLY -= int(subtractedPower*coolant_controls.percentCoolant)
	getSupplyCount += 1
	return SUPPLY
