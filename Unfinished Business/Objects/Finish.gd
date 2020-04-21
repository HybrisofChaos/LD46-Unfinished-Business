extends Area2D

func _on_Finish_body_entered(_body):
	get_tree().change_scene("res://Scenes/Win.tscn")