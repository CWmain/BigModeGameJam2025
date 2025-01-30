extends Node2D

@onready var power_gauge = $PowerGauge

func _process(delta):
	power_gauge.material.set_shader_parameter("percentFull", 0.5)
