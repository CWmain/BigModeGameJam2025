extends Node2D

@onready var rigid_wheel = $RigidWheel
@onready var pin_joint_2d = $PinJoint2D

func _physics_process(_delta):
	if rigid_wheel.broken and pin_joint_2d != null:
		pin_joint_2d.queue_free()
