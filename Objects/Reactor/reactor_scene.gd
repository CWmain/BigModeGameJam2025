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


func _process(_delta):
	if SUPPLY > maxPower:
		power_gauge.breakGauge()
		return
	power_gauge.setGauge(float(SUPPLY)/float(maxPower))

func getSupply()->int:
	SUPPLY = addedPower + (SUPPLY*2)
	SUPPLY -= int(subtractedPower*coolant_controls.percentCoolant)
	return SUPPLY

#From https://easings.net/#easeInOutCirc
func easeInOutCirc(x: float) -> float:
	if x < 0.5:
		return (1 - sqrt(1 - pow(2 * x, 2))) / 2
	else:
		return (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2



func _on_button_pressed():
	SUPPLY = 0
