extends KinematicBody2D

export (float) var speed
export (float) var damage = 25

var hit_audio = preload("res://SFX/AudioHit.tscn")
var collided = false

func _physics_process(delta):
	var velocity = Vector2.RIGHT.rotated(rotation) * speed

	var collision = move_and_collide(velocity * delta)

	if collision:
		if collision.collider.has_method("apply_damage") and not collided:
			collision.collider.apply_damage(damage)
		
		var clone = hit_audio.instance()
		get_parent().add_child(clone)
		clone.playing = true
		collided = true
		queue_free()		
