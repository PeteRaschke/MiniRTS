extends Node2D

var all_units = []
var units_selected = []
var click_position = Vector2()
var dragbox_active = false
var drag_start:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left_click") and !dragbox_active:
		click_position = get_global_mouse_position()
		drag_start = click_position
		$Dragbox.size = Vector2(1, 1)  # Initialize drag box size
		$Dragbox.position = click_position
		dragbox_active = true
	elif dragbox_active:
		var drag_end:Vector2 = get_global_mouse_position()
		var size = drag_end - drag_start
		print(drag_end - drag_start)
		if size.x > 0 and size.y > 0:
			$Dragbox.size = size
		elif size.x > 0 and size.y < 0:
			$Dragbox.position.y = drag_end.y
			$Dragbox.size.y = drag_start.y - drag_end.y
			$Dragbox.size.x = drag_end.x - drag_start.x
		elif size.x < 0 and size.y < 0:
			$Dragbox.position = drag_end
			$Dragbox.size.y = drag_start.y - drag_end.y
			$Dragbox.size.x = drag_start.x - drag_end.x
		else:
			$Dragbox.position.x = drag_end.x
			$Dragbox.size.y = drag_end.y - drag_start.y
			$Dragbox.size.x = drag_start.x - drag_end.x
		
	if Input.is_action_just_released("left_click"):
		# Check all units and add them to selected_units if they are within the drag box
		var drag_box_rect = Rect2($Dragbox.position, $Dragbox.size)  # Create a Rect2 from dragbox position and size
		if drag_box_rect.size > Vector2(2,2):
			units_selected = [] 
		for unit in all_units:
			if drag_box_rect.has_point(unit.position):  # Check if the unit's position is within the drag box
				add_multiple_units(unit)
		$Dragbox.size = Vector2(0,0)
		dragbox_active = false

func add_selected_unit(unit):
	units_selected = []
	units_selected.append(unit)
	print("Unit added:", unit)
	
func add_multiple_units(unit):
	units_selected.append(unit)
	print("Unit added:", unit)	
	
func add_to_all_units(unit):
	all_units.append(unit)
	print("Unit added:", unit)
