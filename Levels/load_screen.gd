extends Node2D

@export_file("*.tscn") var sceneName
@onready var progress_bar = $ProgressBar

@onready var shader_compiler = $ShaderCompiler

var progress = []

func _ready():
	assert(sceneName != null)
	ResourceLoader.load_threaded_request(sceneName)
	
func _process(delta):
	if ResourceLoader.load_threaded_get_status(sceneName, progress) == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(sceneName))
	progress_bar.value = progress[0]*100
	
