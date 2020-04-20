extends KinematicBody2D

export (float) var speed

func _physics_process(delta):
	var velocity = Vector2.RIGHT.rotated(rotation) * speed

	var collision = move_and_collide(velocity * delta)

	if collision:
		#TODO: Do damage, explosion, whatever
		queue_free()
