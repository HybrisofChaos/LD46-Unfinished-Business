extends KinematicBody2D

export (float) var speed = 32.0
export (float) var gravity = 16
export (float) var jump_speed = 256

export (NodePath) var ball_path
var max_ball_range = 48.0
var ball

func _ready():
	ball = get_node(ball_path)
	max_ball_range = (ball.position - position).length() + 3

func _physics_process(delta):
	var velocity = Vector2.ZERO

	var distance = ball.position - position
	var dX = max_ball_range - abs(distance.x)
	var dY = max_ball_range - abs(distance.y)

	if Input.is_action_pressed("player_left"):
		velocity.x = max(-speed, -dX / delta)
	if Input.is_action_pressed("player_right"):
		velocity.x = min(speed, dX / delta)
	if Input.is_action_pressed("player_up"):
		velocity.y = max(-speed, -dY / delta)
	if Input.is_action_pressed("player_down"):
		velocity.y = min(speed, dY / delta)

	#if velocity.x * delta > dX:
	#	velocity.x = dX / delta
		
	velocity = move_and_slide(velocity, Vector2(0, -1))
					

# func _physics_process(_delta):
# 	if Input.is_action_pressed("player_right"):
# 		velocity.x = min(velocity.x + acceleration, max_speed)
# 	if Input.is_action_pressed("player_left"):
# 		velocity.x = max(velocity.x - acceleration, -max_speed)
	
# 	if is_on_floor():
# 		if Input.is_action_pressed("player_jump"):
# 			velocity.y = -jump_speed
	
	
# 	velocity.y += gravity
# 	velocity.y = min(velocity.y, 500)
# 	velocity.x = lerp(velocity.x, 0, 0.25)
# 	velocity = move_and_slide(velocity, Vector2(0,-1))
