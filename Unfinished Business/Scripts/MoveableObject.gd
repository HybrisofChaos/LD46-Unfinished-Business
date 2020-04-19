extends RigidBody2D

export (float) var movementCooldown = 1.5

var dragging = false
var readyToShoot = false
var shootToPos: Vector2
var shootFromPos: Vector2
var shootTimeout = false

var cooldownTimer = movementCooldown

func _ready():
	pass

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
	if Input.is_key_pressed(KEY_Q):
			shootFromPos = get_global_mouse_position()
			if(dragging):
				dragging = false
				if(readyToShoot && !shootTimeout):
					shoot()
					readyToShoot = false
			else:
				shootToPos = get_global_mouse_position()
				dragging = true	
	elif event is InputEventMouseMotion:
		shootFromPos = get_global_mouse_position()
		if(dragging):
			readyToShoot = true	

func shoot():
	var to = Vector2((shootToPos - global_position) - (shootFromPos - global_position))
	print(to)

	apply_central_impulse(Vector2(to.x * 100, to.y * 110))

	shootTimeout = true

func _draw():
	if dragging && !shootTimeout:
		var object = position - global_position
		var cursor = shootFromPos - shootToPos - object

		draw_circle(shootToPos, 1.0, Color(1,1,1))

		draw_line(object, object - cursor, Color(1, 1, 1), 1)		
