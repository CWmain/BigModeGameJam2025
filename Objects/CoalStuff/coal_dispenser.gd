extends Node2D

var coal = preload("res://Objects/CoalStuff/coal.tscn")

func _physics_process(_delta):
	var coals = get_tree().get_nodes_in_group("Coal")

	if coals.size() < 5:
		var c : RigidBody2D = coal.instantiate()
		c.transform = transform
		c.apply_impulse(Vector2(500,0))
		get_tree().get_root().add_child(c)
