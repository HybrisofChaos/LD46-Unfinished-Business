extends KinematicBody2D

export (float) var bounce_speed = 3
export (float) var bounce_range = 5

export (float) var speed = 80

var start_pos

var shoot_counter = 0
var target = null

func _ready():
	start_pos = $AnimatedSprite.position

func _physics_process(delta):
	bounce(delta) 
	if target:
		var velocity = Vector2.ZERO
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed

		move_and_slide(velocity, Vector2(0, -1))

func _on_Area2D_body_entered(node):
	if node.name == "Player":
		target = node

func bounce(delta):
	$AnimatedSprite.position = $AnimatedSprite.position.move_toward(start_pos + Vector2(0, bounce_range), delta * bounce_speed)

	if abs($AnimatedSprite.position.y  - (start_pos.y + bounce_range)) < 0.7:
		bounce_range *= -1
