extends Node



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Test_Click"):
		toggleAllHouses()

## Test function to ensure all homes toggle correctly
func toggleAllHouses():
	var demanaders = get_tree().get_nodes_in_group("Demander")
	for d: House in demanaders:
		d.isDemanding = !(d.isDemanding)

