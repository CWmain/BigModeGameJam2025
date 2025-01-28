extends Node2D

@export var m: Manager
@onready var label = $Label

func _ready():
	assert(m != null)
	m.updateLabel.connect(_on_updateLabel)

func _on_updateLabel():
	label.text = str(m.totalDemand)


