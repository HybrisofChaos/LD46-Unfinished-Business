extends "Enemy.gd"

export (float) var bounce_speed = 3
export (float) var bounce_range = 5

export (float) var speed = 80
export (float) var social_distance = 15
export (float) var fire_range = 25
export (float) var fire_rate = 1.5

var projectile = preload("res://Objects/Entities/DemonProjectile.tscn")

var start_pos

var shot = false
var target = null

var velocity = Vector2.ZERO
var projectile_spawn

func _ready():
	start_pos = $AnimatedSprite.position
	$AnimatedSprite.speed_scale = fire_rate
	projectile_spawn = $ProjectileSpawnRight

func _physics_process(delta):
	bounce(delta) 

	if target:
		var direction = (target.global_position - global_position).normalized()
		var distance = global_position.distance_to(target.global_position)

		if distance <= social_distance:
			velocity = lerp(velocity, Vector2(0, -speed), delta)
		else:
			velocity = lerp(velocity, direction * speed, delta)

		if distance <= fire_range:
			$AnimatedSprite.playing = true
			shoot(direction)
		else:
			$AnimatedSprite.playing = false
			$AnimatedSprite.frame = 0

		velocity = move_and_slide(velocity, Vector2(0, -1))

		if direction.x < 0: 
			$AnimatedSprite.flip_h = true
			projectile_spawn = $ProjectileSpawnLeft
		else:
			$AnimatedSprite.flip_h = false
			projectile_spawn = $ProjectileSpawnRight


func _on_Area2D_body_entered(node):
	if node.name == "Player":
		target = node

func shoot(direction):
	#if shoot_counter < 1.0 / fire_rate: return
	if $AnimatedSprite.frame == 0:
		shot = false

	if $AnimatedSprite.frame == 2 and not shot:
		var clone = projectile.instance()
		add_child(clone)
		clone.global_position = projectile_spawn.global_position
		clone.rotation = direction.angle()
		shot = true

func bounce(delta):
	$AnimatedSprite.position = $AnimatedSprite.position.move_toward(start_pos + Vector2(0, bounce_range), delta * bounce_speed)

	if abs($AnimatedSprite.position.y  - (start_pos.y + bounce_range)) < 0.7:
		bounce_range *= -1
