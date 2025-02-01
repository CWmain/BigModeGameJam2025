extends Node2D

var frameCount: int = 0

func _ready():
	# Emit all particles
	for c in get_children():
		c.emitting = true

func _process(_delta):
	# Deletes self after 120 frames
	if frameCount == 120:
		queue_free()
	frameCount += 1
	
	
