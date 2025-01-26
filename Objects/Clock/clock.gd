extends Node2D

var time: int = 0:
	set(v):
		time = v
		label.text = str(time)
@export var timer: LevelTimer
@onready var label = $Label

func _ready():
	assert(timer != null)
	timer.tick.connect(_on_tick)

func _on_tick():
	time += 1
