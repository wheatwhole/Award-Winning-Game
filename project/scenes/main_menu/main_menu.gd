extends Node

func _ready():
	pass
	


func _on_play_button_up():
	get_tree().change_scene_to_file("res://scenes/levels/island_select/island_select.tscn") # Replace with function body.


func _on_quit_button_up():
	get_tree().quit() # Replace with function body.
