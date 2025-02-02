extends Node2D

var onButton: bool = false

@onready var pause_button = $PauseButton
@onready var pause_button_hover = $PauseButtonHover

signal pauseGame

func _process(delta):
	if onButton and Input.is_action_just_pressed("Hold"):
		print("Pause game")
		pauseGame.emit()
		
func _on_area_2d_mouse_entered():
	pause_button.hide()
	pause_button_hover.show()
	onButton = true


func _on_area_2d_mouse_exited():
	pause_button.show()
	pause_button_hover.hide()
	onButton = false
