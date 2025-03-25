extends GridContainer

var current_units = []

func _ready():
	for i in 54:
		var new_button = Button.new()
		new_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		new_button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		new_button.focus_mode = Control.FOCUS_NONE
		new_button.icon = preload("res://icon.svg")
		new_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		new_button.add_theme_constant_override("icon_max_width", 64)
		new_button.add_theme_constant_override("icon_spacing", 8)
		new_button.add_theme_constant_override("hseparation", 4)
		new_button.modulate.a = 0
		add_child(new_button)

func _process(delta):
	var player_interface = get_node_or_null("/root/Map/Player_Interface")
	if player_interface and player_interface.units_selected != current_units:
		for child in get_children():
			if child is Button:
				child.modulate.a = 0

		current_units = player_interface.units_selected
		
		var unit_count = 0
		for child in get_children():
			if unit_count < current_units.size() and child is Button:
				var icon_path = "res://art/icons/"+ current_units[unit_count].NAME + "_icon.png"
				child.icon = load(icon_path)
				child.modulate.a = 1
				unit_count+=1
