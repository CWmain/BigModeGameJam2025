extends Node2D

@export var sm: SupplyManager
@onready var label = $Label

func _ready():
	assert(sm != null)
	sm.updateLabel.connect(_on_updateLabel)

func _on_updateLabel():
	label.text = str(sm.totalSupply)


