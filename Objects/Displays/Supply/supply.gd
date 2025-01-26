extends Node2D

@export var dm: DemandManager
@onready var label = $Label

func _ready():
	assert(dm != null)
	dm.updateLabel.connect(_on_updateLabel)

func _on_updateLabel():
	label.text = str(dm.totalDemand)


