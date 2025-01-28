extends Node2D

@export var MAX_COAL: int = 5
@export var LAUNCH_SPEED: int = 500
var coal = preload("res://Objects/CoalStuff/coal.tscn")

func _physics_process(_delta):
	var coals = get_tree().get_nodes_in_group("Coal")

	if coals.size() < 5:
		var newCoal : RigidBody2D = coal.instantiate()
		newCoal.transform = transform
		newCoal.apply_impulse(Vector2(LAUNCH_SPEED,0))
		get_parent().add_child(newCoal)
