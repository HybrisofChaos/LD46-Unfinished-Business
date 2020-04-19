extends RigidBody2D

export (float) var movementCooldown = 1.5
export (NodePath) var camera

var dragging = false
var readyToShoot = false
var shootToEvent: InputEvent
var shootFromEvent: InputEvent
var shootTimeout = false

var cooldownTimer = movementCooldown

func _ready():
	if get_node(camera) is Camera2D:
		camera = get_node(camera)
	else:
		print("Camera should be Camera2D node")	

func _process(delta):
	update() 
	updateCooldownTimer(delta)

func updateCooldownTimer(delta):	
	if shootTimeout:
		cooldownTimer = cooldownTimer - delta
		if cooldownTimer <= 0:
			shootTimeout = false
			cooldownTimer = movementCooldown

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			shootFromEvent = event
			if(dragging):
				dragging = false
				if(readyToShoot && !shootTimeout):
					shoot()
					readyToShoot = false
			else:
				shootToEvent = event
				dragging = true	
	elif event is InputEventMouseMotion:
		shootFromEvent = event
		if(dragging):
			readyToShoot = true	

func shoot():
	var to = Vector2((shootToEvent.position - global_position) - (shootFromEvent.position - global_position))
	print(to)

	apply_central_impulse(Vector2(to.x * 250, to.y * 300))

	shootTimeout = true

func _draw():
	if dragging && !shootTimeout:
		var object = position - global_position
		var cursor = shootFromEvent.position - shootToEvent.position

		draw_circle(shootToEvent.position, 1.0, Color(1,1,1))
		draw_line(object, object - cursor, Color(1, 1, 1), 1)		
