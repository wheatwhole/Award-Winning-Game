extends Node
class_name LevelSelect

@onready var current_level: LevelIcon = $"Scene Objects/LevelIcon"
@onready var plricon: Node = $"Scene Objects/plricon"

var parent_island_select: Node

var back: int = 0
# Called when the node enters the scene tree for the first time.
func _ready(): 
	plricon.global_position = current_level.global_position

func close():
	if parent_island_select:
		get_tree().get_root().add_child(parent_island_select) # When the island select script teleports you here, it also sets the Parent Island Select variable to the island select screen. This script adds it as an element to this scene. Then this scene sets its stage to the island select screen. Finally, this scene deletes itself
		get_tree().current_scene = parent_island_select
		get_tree().get_root().remove_child(self)
		print("eco friendly wood veneers")
		back = 0 #custom variable for the custom back button code below.
func _on_back_button_up():
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent):
	if event.is_action_pressed("left") and current_level.next_level_left:
			current_level = current_level.next_level_left
			plricon.global_position = current_level.global_position
	if event.is_action_pressed("right") and current_level.next_level_right:
			current_level = current_level.next_level_right
			plricon.global_position = current_level.global_position
	if event.is_action_pressed("jump") and current_level.next_level_up:
			current_level = current_level.next_level_up
			plricon.global_position = current_level.global_position	
	if event.is_action_pressed("down") and current_level.next_level_down:
			current_level = current_level.next_level_down
			plricon.global_position = current_level.global_position
	if event.is_action_pressed("cancel"):
		close()
	
	
	if event.is_action_released("accept"):
		print(Global.level_status(current_level.worldwide_level_ID-1))
		if current_level.next_scene_path and Global.level_status(current_level.worldwide_level_ID-1) == true:
			get_tree().change_scene_to_file(current_level.next_scene_path)
