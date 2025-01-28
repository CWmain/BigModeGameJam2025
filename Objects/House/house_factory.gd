extends Node2D

## Generates "toGenerate" number of houses of row length "rowLength"
@export var rowLength: int = 1
@export var toGenerate: int = 1

## The width gap between houses
@export var HOUSE_WIDTH: int = 32
## The height gap between houses
@export var HOUSE_HEIGHT: int = 32

@export var m: Manager

var houseToPlace = preload("res://Objects/House/house.tscn")
var toPlacePosition: Vector2 = Vector2.ZERO 

func _ready():
	assert(m != null)
	var i : int = 0
	while i < toGenerate:
		var curHouse: House = houseToPlace.instantiate()
		curHouse.position = toPlacePosition
		# Adds onto demandList for random selection in manager
		m.demandList.append(curHouse)
		add_child(curHouse)
		toPlacePosition += Vector2(HOUSE_WIDTH, 0)
		# Max row sized reach, so reset to new row
		if (toPlacePosition[0] > HOUSE_WIDTH*(rowLength-1)):
			toPlacePosition[0] = 0
			toPlacePosition[1] += HOUSE_HEIGHT
		i += 1
