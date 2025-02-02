extends Node2D

@onready var power_gauge = $PowerGauge

@onready var constant_explosion = $ConstantExplosion

@onready var flow = $Flow

func setGauge(percent: float) -> void:
	assert(percent >= 0.0 and percent <= 1.0)
	power_gauge.material.set_shader_parameter("percentFull", percent)

func breakGauge() -> void:
	constant_explosion.emitting = true
	flow.play()
