extends KinematicBody2D

export (NodePath) var ball_path
export (float) var speed = 32.0
export (float) var ball_resting_distance = 20
export (float) var lerp_weight = 3
export (float) var lerp_scaling_cutoff = 32.0

export (float) var max_health = 100
var current_health = 100
export (float) var health_regen = 8

var health_regen_counter = 0
var health_regen_cooldown = 3

const platform_collision_layer = 19
var current_collision_mask
var ball

func _ready():
	ball = get_node(ball_path)
	current_collision_mask = get_collision_mask()
	current_health = max_health

func _process(delta):
	if health_regen_counter >= health_regen_cooldown:
		current_health = min(current_health + health_regen * delta, max_health)
	else:
		health_regen_counter += delta


func _physics_process(delta):
	move(delta)

	if ball.shootTimeout:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, Vector2(0 , -1), [self, $Collider, $ChainPoint, ball.get_node("Area2D")], collision_mask)
		if result.size() != 0:
			set_collision_mask_bit(platform_collision_layer, false)
			
	else:
		set_collision_mask_bit(platform_collision_layer, true)

func move(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("player_left"):
		velocity.x = -speed
		$Sprite.flip_h = true
	if Input.is_action_pressed("player_right"):
		velocity.x = speed
		$Sprite.flip_h = false

	if Input.is_action_pressed("player_up"):
		velocity.y = -speed
	if Input.is_action_pressed("player_down"):
		velocity.y = speed
		
	if velocity == Vector2.ZERO and position.distance_to(ball.position) > ball_resting_distance:
		position = position.move_toward(ball.position,
										delta * (lerp_weight * (1 + ball.linear_velocity.length() / lerp_scaling_cutoff))
										)

	velocity = move_and_slide(velocity, Vector2(0, -1))

func apply_damage(damage):
	current_health -= damage
	health_regen_counter = 0
	if current_health <= 0:
		die()

func die():
	get_tree().change_scene("res://Scenes/GameOVer.tscn")
