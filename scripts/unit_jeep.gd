extends CharacterBody2D

const NAME = "Jeep"
const TYPE = 0 #0 == unit type
var speed = 300.0
var click_position = Vector2()
var target_position = Vector2()
var is_moving = false

@onready var navigation_agent_2d = $NavigationAgent2D

func _ready():
	var player_interface = get_node_or_null("/root/Map/Player_Interface")
	if player_interface:
		player_interface.add_to_all_units(self)
	click_position = position

"""func _physics_process(delta):
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
			is_moving = false """
			
		
func _physics_process(delta):
	var player_interface = get_node_or_null("/root/Map/Player_Interface")
	if player_interface and self in player_interface.units_selected:
		if Input.is_action_just_pressed("right_click"):
			click_position = get_global_mouse_position()
			is_moving = true
			
	if is_moving:
		navigation_agent_2d.target_position = click_position
		var current_agent_position = global_position
		var next_path_position = navigation_agent_2d.get_next_path_position()
		var angle_radians = atan2(click_position.y - position.y, click_position.x - position.x)
		var angle_degrees = rad_to_deg(angle_radians)
		
		if angle_degrees > -135 and angle_degrees < -40:
			$AnimatedSprite2D.play("jeep_north")
		elif angle_degrees > -40 and angle_degrees < 35:
			$AnimatedSprite2D.play("jeep_east")
		elif angle_degrees > 35 and angle_degrees < 140:
			$AnimatedSprite2D.play("jeep_south")
		else:
			$AnimatedSprite2D.play("jeep_west")
			
		var new_velocity = current_agent_position.direction_to(next_path_position) * speed
		if navigation_agent_2d.avoidance_enabled:
			navigation_agent_2d.set_velocity(new_velocity)
		else:
			_on_navigation_agent_2d_velocity_computed(new_velocity)
			
		velocity = navigation_agent_2d.get_velocity()
		move_and_slide()
		
		if position.distance_to(click_position) < 3:
			is_moving = false



func getType():
	return TYPE


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
