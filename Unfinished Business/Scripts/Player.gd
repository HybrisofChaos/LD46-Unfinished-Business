extends KinematicBody2D

export (float) var max_speed = 64.0
export (float) var acceleration = 8
export (float) var gravity = 16
export (float) var jump_speed = 256

var velocity = Vector2.ZERO

func _physics_process(_delta):
	if Input.is_action_pressed("player_right"):
		velocity.x = min(velocity.x + acceleration, max_speed)
	if Input.is_action_pressed("player_left"):
		velocity.x = max(velocity.x - acceleration, -max_speed)
	
	if is_on_floor():
		if Input.is_action_pressed("player_jump"):
			velocity.y = -jump_speed
	
	
	velocity.y += gravity
	velocity.y = min(velocity.y, 500)
	velocity.x = lerp(velocity.x, 0, 0.25)
	velocity = move_and_slide(velocity, Vector2(0,-1))
