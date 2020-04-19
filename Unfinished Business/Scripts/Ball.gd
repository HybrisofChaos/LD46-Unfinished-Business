extends RigidBody2D

export (float) var movementCooldown = 1.5
export (int) var maxSpeed = 80
export (NodePath) var camera

var dragging = false
var readyToShoot = false
var shootToPos: Vector2
var shootFromPos: Vector2
var shootTimeout = false

var cooldownTimer = 0

func _ready():
	if get_node(camera) is Camera2D:
		camera = get_node(camera)
	else:
		print("Camera should be Camera2D node")	

func _process(delta):
	update() 
	updateCooldownTimer(delta)
	checkForInput()
	checkAndLimitMaxSpeed()

func updateCooldownTimer(delta):	
	if shootTimeout:
		cooldownTimer = cooldownTimer - delta
		if cooldownTimer <= 0:
			shootTimeout = false
			cooldownTimer = movementCooldown

func checkAndLimitMaxSpeed():
	if abs(get_linear_velocity().x) > maxSpeed or abs(get_linear_velocity().y) > maxSpeed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= maxSpeed
		set_linear_velocity(new_speed)

func checkForInput():
	if Input.is_action_just_pressed("lmb") || Input.is_action_just_released("lmb"):
		shootFromPos = get_global_mouse_position()
		if(dragging):
			dragging = false
			if(readyToShoot && !shootTimeout):
				shoot()
			readyToShoot = false
		else:
			shootToPos = get_global_mouse_position()
			dragging = true		

func _input(event):
	if event is InputEventMouseMotion:
		shootFromPos = get_global_mouse_position()
		if(dragging):
			readyToShoot = true	

func shoot():
	var to = Vector2((shootToPos - global_position) - (shootFromPos - global_position))

	if to.y > 30:
		to.y = 30
	if to.y < -30:
		to.y = -30	

	if to.x > 30:
		to.x = 30
	if to.x < -30:
		to.x = -30		

	apply_central_impulse(Vector2(to.x * 250, to.y * 300))

	shootTimeout = true

func _draw():
	if dragging && !shootTimeout:
		var ball = position - global_position
		var cursor = shootFromPos - shootToPos - ball

		#FUCKED
		#draw_circle(shootToPos, 1.0, Color(1,1,1))

		draw_line(ball, ball - cursor, Color(1, 1, 1), 1)		
