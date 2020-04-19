extends KinematicBody2D

export (NodePath) var ball_path
export (float) var speed = 32.0
export (float) var ball_resting_distance = 20
export (float) var lerp_weight = 3
export (float) var lerp_scaling_cutoff = 32.0

var ball

func _ready():
	ball = get_node(ball_path)

func _physics_process(delta):
	move(delta)

	if ball.shootTimeout:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, Vector2(0 , -1), [self, self.get_children()])
		if result.size() != 0:
			$Collider.disabled = true
		else:
			$Collider.disabled = false
	else:
		$Collider.disabled = false

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

