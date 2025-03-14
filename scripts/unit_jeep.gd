extends CharacterBody2D

const NAME = "Jeep"
const TYPE = 0 #0 == unit type
var speed = 300.0
var click_position = Vector2()
var target_position = Vector2()
var is_moving = false


func _ready():
	var player_interface = get_node_or_null("/root/Map/Player_Interface")
	if player_interface:
		player_interface.add_to_all_units(self)
	click_position = position

func _physics_process(delta):
	var player_interface = get_node_or_null("/root/Map/Player_Interface")
	if player_interface and self in player_interface.units_selected:
		if Input.is_action_just_pressed("right_click"):
			click_position = get_global_mouse_position()
			is_moving = true
		
	if is_moving:
		var angle_radians = atan2(click_position.y - position.y, click_position.x - position.x)
		var angle_degrees = rad_to_deg(angle_radians)
		print(angle_degrees)
		if angle_degrees > -135 and angle_degrees < -40:
			$AnimatedSprite2D.play("jeep_north")
		elif angle_degrees > -40 and angle_degrees < 35:
			$AnimatedSprite2D.play("jeep_east")
		elif angle_degrees > 35 and angle_degrees < 140:
			$AnimatedSprite2D.play("jeep_south")
		else:
			$AnimatedSprite2D.play("jeep_west")
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		move_and_slide()
		if position.distance_to(click_position) < 3:
			is_moving = false
			
		




func getType():
	return TYPE
