extends Node2D

@export var m: Manager
@onready var label = $Label
@onready var color_rect = $ColorRect

func _ready():
	assert(m != null)
	m.updateLabel.connect(_on_updateLabel)

func _on_updateLabel():
	label.text = str(m.totalSupply)
	if m.overSupply:
		color_rect.color = Color(255,0,0)
	else:
		color_rect.color = Color(0,0,0)


