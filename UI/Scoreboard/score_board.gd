extends Control

@export var saveFileString: String = "user://save_game.txt"
@onready var list = $List


func loadScores():
	var file = FileAccess.open("user://save_game.txt", FileAccess.READ)
	var stringFile: String
	if (FileAccess.file_exists(saveFileString)):
		file = FileAccess.open("user://save_game.txt", FileAccess.READ)
		stringFile = file.get_as_text()
		file.close()
	
	# Get the highscore list
	var highScores: Array[int]
	if (stringFile.length() > 0):
		highScores = str_to_var(stringFile)
	
	# Re-sort highscore list
	highScores.sort()
	print(highScores)
	# Generate labels and append to list
	for s in highScores:
		var item = Label.new()
		item.text = str(s)

		item.add_theme_font_size_override("font_size", 32)
		list.add_child(item)
		list.move_child(item, 0)

func removeListChildren():
	for child in list.get_children():
		list.remove_child(child)
		child.queue_free()
