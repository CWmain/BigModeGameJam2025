extends Node2D

# Fire particle from 16BitDev https://www.youtube.com/watch?v=SqLVJxl7bNw&ab_channel=16BitDev

@onready var fire_1 = $FireParticles/Fire1
@onready var fire_2 = $FireParticles/Fire2
@onready var fire_3 = $FireParticles/Fire3
@onready var big_fire = $FireParticles/BigFire

@export var powerPerCoal : int = 50

## When this power is exceeded triggers a fire
@export var maxPower : int = 200
@export var powerDecreasePerTick: int = 10

var SUPPLY : int = 0
var broken: bool = false

func _process(_delta):
	#Do nothing if broken
	if broken:
		return
	# Func to display current coal generator capacity
	progressFires()
	
	# If overworked breaks
	if SUPPLY > maxPower:
		bigFire()

func getSupply() -> int:
	if broken:
		return 0
		
	var toReturn: int = SUPPLY
	SUPPLY -= powerDecreasePerTick
	if SUPPLY < 0:
		SUPPLY = 0
	
	return toReturn

func progressFires():
	if SUPPLY == 0:
		fire_1.emitting = false
		fire_2.emitting = false
		fire_3.emitting = false
	
	if SUPPLY > 0 and SUPPLY < 100:
		fire_1.emitting = true
		fire_2.emitting = false
		fire_3.emitting = false
		
	if SUPPLY >= 100 and SUPPLY < 150:
		fire_1.emitting = true
		fire_2.emitting = true
		fire_3.emitting = false
		
	if SUPPLY >= 150 and SUPPLY < 200:
		fire_1.emitting = true
		fire_2.emitting = true
		fire_3.emitting = true

func bigFire() -> void:
	fire_1.emitting = false
	fire_2.emitting = false
	fire_3.emitting = false
	big_fire.emitting = true
	print("Furnace combusted")
	broken = true
	SUPPLY = 0


func _on_collection_body_entered(body):
	if typeof(body) != typeof(Coal):
		print("Wrong type")
		return
	SUPPLY += powerPerCoal
	body.destroy()
	print("Coal Collected")
	
