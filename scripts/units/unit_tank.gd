extends CharacterBody2D

const NAME = "tank"
const TYPE = 0 #0 == unit type
var team = 1
var speed = 200.0
var health = 50
var click_position = Vector2()
var target_position = Vector2()
var is_moving = false

@onready var navigation_agent_2d = $NavigationAgent2D

func _ready():
	var player_interface = get_node_or_null("/root/Map/Player_Interface")
	if player_interface:
		player_interface.add_to_all_units(self)
	click_position = position

func _physics_process(delta):
	update_health()
	
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
		if angle_degrees < 0:
			angle_degrees = 360 + angle_degrees
		
		if angle_degrees > 337.5 or angle_degrees <= 22.5:
			$AnimatedSprite2D.play("tank_east")
		elif angle_degrees > 22.5 and angle_degrees <= 67.5:
			$AnimatedSprite2D.play("tank_south_east")
		elif angle_degrees > 67.5 and angle_degrees <= 112.5:
			$AnimatedSprite2D.play("tank_south")
		elif angle_degrees > 112.5 and angle_degrees <= 157.5:
			$AnimatedSprite2D.play("tank_south_west")
		elif angle_degrees > 157.5 and angle_degrees <= 202.5:
			$AnimatedSprite2D.play("tank_west")
		elif angle_degrees > 202.5 and angle_degrees <= 247.5:
			$AnimatedSprite2D.play("tank_north_west")
		elif angle_degrees > 247.5 and angle_degrees <= 292.5:
			$AnimatedSprite2D.play("tank_north")
		elif angle_degrees > 292.5 and angle_degrees <= 337.5:
			$AnimatedSprite2D.play("tank_north_east")
			
		var new_velocity = current_agent_position.direction_to(next_path_position) * speed
		if navigation_agent_2d.avoidance_enabled:
			navigation_agent_2d.set_velocity(new_velocity)
		else:
			_on_navigation_agent_2d_velocity_computed(new_velocity)
			
		velocity = navigation_agent_2d.get_velocity()
		move_and_slide()
		
		if position.distance_to(click_position) < 3:
			is_moving = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 50:
		healthbar.visible = false
	else:
		healthbar.visible = true
	if health <= 0:
		for unit in $"../Player_Interface".all_units:
			if unit == self:
				unit = null
		$explosion.emitting = true
		$AnimatedSprite2D.visible = false
		var timer = Timer.new()
		timer.wait_time = .5
		timer.one_shot = true
		add_child(timer)
		timer.start()
		timer.timeout.connect(_on_explosion_finnished)
		
		

func _on_explosion_finnished():
	self.queue_free()

func getType():
	return TYPE

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		get_node("/root/Map/Player_Interface").add_selected_unit(self)
		print("Tank Selected")
