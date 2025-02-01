extends Node2D

var loadScreen = preload("res://Levels/load_screen.tscn")

func _on_start_pressed():
	print("Go to load screen to background load level / particles")
	get_tree().change_scene_to_packed(loadScreen)

func _on_settings_pressed():
	print("Hide menu options and show settings options")
