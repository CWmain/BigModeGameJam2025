extends Timer
class_name LevelTimer

signal tick

func _on_timeout():
	tick.emit()
