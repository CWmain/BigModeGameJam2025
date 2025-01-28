extends Timer
class_name LevelTimer

# Consider having different ticks for different systems if lag becomes an issue 
signal updateDemand
signal updateSupply

signal tick

var tickCount: int = 0

func _on_timeout():
	updateDemand.emit()
	updateSupply.emit()

	tick.emit()
	tickCount += 1
