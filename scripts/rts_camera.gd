extends CharacterBody2D

var speed = 400

func get_input():
	var input_direction = Input.get_vector("left_key", "right_key", "up_key", "down_key")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
