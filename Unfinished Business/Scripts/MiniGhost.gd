extends KinematicBody2D

export (float) var speed
export (float) var damage = 25

func _physics_process(delta):
	var velocity = Vector2.RIGHT.rotated(rotation) * speed

	var collision = move_and_collide(velocity * delta)

	if collision:
		print(collision.collider.name)
		if collision.collider.has_method("apply_damage"):
			collision.collider.apply_damage(damage)

		queue_free()
