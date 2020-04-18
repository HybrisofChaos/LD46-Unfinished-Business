extends KinematicBody2D

export (float) var speed = 32.0

func _physics_process(_delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("player_left"):
		velocity.x = -speed
	if Input.is_action_pressed("player_right"):
		velocity.x = speed
	if Input.is_action_pressed("player_up"):
		velocity.y = -speed
	if Input.is_action_pressed("player_down"):
		velocity.y = speed
		
	velocity = move_and_slide(velocity, Vector2(0, -1))
