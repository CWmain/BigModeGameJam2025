extends Node2D

class_name House

@onready var dark = $Dark
@onready var light = $Light

## Setup to toggle graphics to match isDemanding state
var isDemanding: bool = false:
	set(value):
		if value:
			dark.hide()
			light.show()
		else:
			light.hide()
			dark.show()

var DEMAND: int = 100
