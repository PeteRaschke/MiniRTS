extends Area2D

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		var parent = get_parent()
		get_node("/root/Map/Player_Interface").add_selected_unit(parent)
		print("Jeep Selected")
