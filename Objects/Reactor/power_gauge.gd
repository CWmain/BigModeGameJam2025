extends Node2D

@onready var power_gauge = $PowerGauge

func _process(_delta):
	power_gauge.material.set_shader_parameter("percentFull", 0.5)
