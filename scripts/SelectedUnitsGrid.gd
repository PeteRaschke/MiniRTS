extends GridContainer

var current_units = []

func _ready():
	for i in 54:
		var new_button = Button.new()
		new_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		new_button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		new_button.focus_mode = Control.FOCUS_NONE
		new_button.icon = preload("res://icon.svg")
		new_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER  # Keep it centered
		# Override theme properties to scale the icon properly
		new_button.add_theme_constant_override("icon_max_width", 64)  # Adjust width
		new_button.add_theme_constant_override("icon_spacing", 8)  # Adjust spacing
		new_button.add_theme_constant_override("hseparation", 4)  # Adjust horizontal separation
		new_button.modulate.a = 0  # Set alpha to 0 (fully transparent)
		add_child(new_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_interface = get_node_or_null("/root/Map/Player_Interface")
	if player_interface and player_interface.units_selected != current_units:
		for child in get_children():
			if child is Button:
				child.modulate.a = 0
		
		# Update current selection **before looping**
		current_units = player_interface.units_selected
		
		# Update buttons
		var unit_count = 0
		for child in get_children():
			if unit_count < current_units.size() and child is Button:
				var icon_path = "res://art/icons/"+ current_units[unit_count].NAME + "_icon.png"
				child.icon = load(icon_path)
				child.modulate.a = 1
				unit_count+=1
		
		
		
		#var y_offset = 0
		#for unit in current_units:
			#var new_button = Button.new()
			#new_button.text = unit.NAME
			#new_button.position = Vector2(10, y_offset)  # Adjust button position
			#add_child(new_button)
			#y_offset += 40  # Move the next button down
