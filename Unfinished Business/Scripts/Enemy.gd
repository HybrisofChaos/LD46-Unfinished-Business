extends KinematicBody2D

class_name Enemy

var max_health = 100
var current_health = 100

func _ready():
    current_health = max_health

func apply_damage(damage):
    current_health -= damage
    $AudioHurt.playing = false
    $AudioHurt.playing = true
    if current_health <= 0:
        die()

func die():
    queue_free()