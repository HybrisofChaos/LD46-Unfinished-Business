extends "Enemy.gd"

export (float) var bounce_speed = 3
export (float) var bounce_range = 5

var start_pos

var shoot_counter = 0
var target = null

var path

const MOVEMENT_SPEED = 20
const POINT_RADIUS = 1

func _ready():
	start_pos = $AnimatedSprite.position

func _physics_process(delta):
	bounce(delta) 

	#if target:
		#var velocity = Vector2.ZERO
		#var direction = (target.global_position - global_position).normalized()
		#velocity = direction * speed

		#move_and_slide(velocity, Vector2(0, -1))

func _process(_delta):
	if path:	
		var target = path[0]
		var velocity = Vector2.ZERO
		var direction = (target - position).normalized()
		velocity = direction * MOVEMENT_SPEED

		move_and_slide(velocity, Vector2(0, -1))
		
		if position.distance_to(target) < POINT_RADIUS:
		
			path.remove(0)
		
			if path.size() == 0:
				path = null

func bounce(delta):
	$AnimatedSprite.position = $AnimatedSprite.position.move_toward(start_pos + Vector2(0, bounce_range), delta * bounce_speed)

	if abs($AnimatedSprite.position.y  - (start_pos.y + bounce_range)) < 0.7:
		bounce_range *= -1
