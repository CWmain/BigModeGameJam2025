extends Node2D

@onready var power_gauge = $PowerGauge

func setGauge(percent: float) -> void:
	assert(percent >= 0.0 and percent <= 1.0)
	power_gauge.material.set_shader_parameter("percentFull", percent)
