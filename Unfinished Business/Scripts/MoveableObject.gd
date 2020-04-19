extends RigidBody2D

export (float) var movementCooldown = 1.5

var dragging = false
var readyToShoot = false
var shootToPos: Vector2
var shootFromPos: Vector2
var shootTimeout = false

var cooldownTimer = 0

func _ready():
	pass

func _process(delta):
	update() 
	updateCooldownTimer(delta)
	checkForInput()

func updateCooldownTimer(delta):	
	if shootTimeout:
		cooldownTimer = cooldownTimer - delta
		if cooldownTimer <= 0:
			shootTimeout = false
			cooldownTimer = movementCooldown

func checkForInput():
	if Input.is_action_just_pressed("telekenesis"):
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

	apply_central_impulse(Vector2(to.x * 100, to.y * 110))

	shootTimeout = true

func _draw():
	if dragging && !shootTimeout:
		var object = position - global_position
		var cursor = shootFromPos - shootToPos - object

		#FUCKED
		#draw_circle(shootToPos, 1.0, Color(1,1,1))

		draw_line(object, object - cursor, Color(1, 1, 1), 1)		
