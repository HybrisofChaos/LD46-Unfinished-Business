extends RigidBody2D

export (int) var movementCooldown = 3

var dragging = false
var readyToShoot = false
var shootToEvent: InputEvent
var shootFromEvent: InputEvent
var shootTimeout = false

func _ready():
	pass

func setShootTimeoutTimer():
	var _timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(movementCooldown)
	_timer.start()

func _on_Timer_timeout():
	shootTimeout = false;

func _physics_process(_delta):
	update() 
	
func _input(event):
	shootFromEvent = event
	if event is InputEventMouseButton:
		if(dragging):
			dragging = false
			if(readyToShoot && !shootTimeout):
				shoot()
				readyToShoot = false
		else:
			shootToEvent = event
			dragging = true	
	elif event is InputEventMouseMotion:
		if(dragging):
			readyToShoot = true	

func shoot():
	var to = Vector2((shootToEvent.position - global_position) - (shootFromEvent.position - global_position))
	print(to)

	apply_central_impulse(Vector2(to.x * 250, to.y * 300))

	shootTimeout = true
	setShootTimeoutTimer()

func _draw():
	if dragging && !shootTimeout:
		var ball = position - global_position
		var cursor = shootFromEvent.position - shootToEvent.position - ball

		draw_circle(shootToEvent.global_position, 2, Color(1,1,1))

		draw_line(ball, ball - cursor, Color(1, 1, 1), 1)		
