extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 9:
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
		#new_button.modulate.a = 0  # Set alpha to 0 (fully transparent)
		add_child(new_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
