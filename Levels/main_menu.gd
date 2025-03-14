extends Node2D

var loadScreen = preload("res://Levels/load_screen.tscn")
@onready var score_board = $ScoreBoard
@onready var menu_options = $MenuOptions

@onready var settings = $Settings

func _on_start_pressed():
	print("Go to load screen to background load level / particles")
	get_tree().change_scene_to_packed(loadScreen)

func _on_settings_pressed():
	print("Hide menu options and show settings options")
	menu_options.hide()
	settings.show()

func _on_scores_pressed():
	print("Show the stored scores")
	score_board.loadScores()
	menu_options.hide()
	score_board.show()


func _on_back_button_pressed():
	score_board.hide()
	# Removes all previous children as they may differ
	score_board.removeListChildren()
	menu_options.show()




func _on_settings_closed_settings():
	menu_options.show()
	settings.hide()


func _on_exit_pressed():
	get_tree().quit()
