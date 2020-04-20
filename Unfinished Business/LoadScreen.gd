extends Node2D

var counter = 0
func _process(delta):
	counter += delta

	if counter >= 0.1:
		get_tree().change_scene("res://Scenes/Level1.tscn")