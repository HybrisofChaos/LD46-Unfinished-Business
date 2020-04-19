extends Node2D

export (float) var bounce_speed = 3
export (float) var bounce_range = 5

var projectile = preload("res://Objects/Entities/mini_ghost.tscn")
export (float) var attack_speed = 5

var start_pos

var shoot_counter = 0

func _ready():
	start_pos = $AnimatedSprite.position

func _process(delta):
	if Input.is_action_pressed("player_shoot"):
		shoot()

	bounce(delta)

	shoot_counter += delta

func shoot():
	if shoot_counter < 1.0 / attack_speed:
		return

	$AnimatedSprite.get_node("Particles2D").restart()
	
	var clone = projectile.instance()
	add_child(clone)
	clone.set_global_position(global_position)
	
	var mouse_position = get_local_mouse_position()
	clone.rotation = mouse_position.angle()
	shoot_counter = 0


func bounce(delta):
	$AnimatedSprite.position.y = lerp($AnimatedSprite.position.y, start_pos.y + bounce_range, delta * bounce_speed)

	if abs($AnimatedSprite.position.y  - (start_pos.y + bounce_range)) < 0.4:
		bounce_range *= -1
