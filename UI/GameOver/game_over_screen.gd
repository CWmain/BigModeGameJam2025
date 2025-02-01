extends Control

@export var timer: LevelTimer
 
@onready var points = $Location/Points

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(timer != null)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func reveal():
	points.text =  str(timer.tickCount)
	show()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")

func _on_retry_pressed():
	get_tree().reload_current_scene()
