# This is the level manager. This script is in every level of the game and manages points and level completion

extends Node
class_name LevelManager 

@onready var points_panel = get_parent().get_node("UI/level_ui/points")
@onready var player = get_parent().get_node("Scene Objects/CharacterBody2D")
@onready var trophy: Trophy = get_parent().get_node("Scene Objects/trophy")
@onready var level = $".."

func _ready():
	pass

func add_point():
	points_panel.points += 1
	print(points_panel.points)
	points_panel.label.text = str("points - ", points_panel.points)

func _on_trophy_body_entered(body):
	if (body.name == "CharacterBody2D"):
		Global.unlock_level(trophy.next_level-1)
		print("trophy next level: ", trophy.next_level-1) #subtract 1s, since 0 in an Array is the first item, 1 is second, so on
		print(Global.level_status(trophy.next_level-1)) # prints "available"
		# get_tree().change_scene_to_file(trophy.next_scene) # Replace with function body.
		if trophy.next_scene:
			trophy.next_scene.parent_level = level # When a trophy is collected, it teleports you to the island selection screen. Parent Level is a variable in that level selection screen that can be set to any Node. The reason why we set it to this level is so the island select screen knows which level we came from. This script adds the level selection screen to its elements. Then it sets the stage to the level selection screen. Finally, the island screen deletes itself to prevent overlapping.
			var trophy_next_scene = trophy.next_scene
			# await get_tree().create_timer(1).timeout
			trophy.call_deferred("queue_free")
			
			await trophy.tree_exited
			get_tree().get_root().add_child(trophy.next_scene)
			get_tree().current_scene = trophy_next_scene
			get_tree().get_root().remove_child(level)
