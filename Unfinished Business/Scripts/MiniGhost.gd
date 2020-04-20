extends KinematicBody2D

export (float) var speed
export (float) var damage = 25

var hit_audio = preload("res://SFX/AudioHit.tscn")

func _physics_process(delta):
	var velocity = Vector2.RIGHT.rotated(rotation) * speed

	var collision = move_and_collide(velocity * delta)

	if collision:
		print(collision.collider.name)
		if collision.collider.has_method("apply_damage"):
			collision.collider.apply_damage(damage)
		
		var clone = hit_audio.instance()
		get_parent().add_child(clone)
		clone.playing = true
		queue_free()		
