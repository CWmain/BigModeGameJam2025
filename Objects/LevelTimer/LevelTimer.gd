extends Timer
class_name LevelTimer

# Consider having different ticks for different systems if lag becomes an issue 
signal updateDemand
signal updateSupply

signal tick

func _on_timeout():
	updateDemand.emit()
	updateSupply.emit()

	tick.emit()
