extends Sprite

export var bounce_speed = 3
export var bounce_range = 5

func _process(delta):
	position.y = lerp(position.y, bounce_range, delta * bounce_speed)

	if abs(position.y - bounce_range) < 0.45:
		bounce_range *= -1