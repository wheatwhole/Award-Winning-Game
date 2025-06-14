extends Control
class_name IslandSelect

@onready var islands: Array = []
@onready var plricon: Node = $"Scene Objects/plricon"
@onready var current_island: IslandIcon = $"Scene Objects/Cloud Forest"
var parent_level: Node
func _ready():
	plricon.global_position = current_island.global_position

func get_island_node_from_id(id: int):
	var island_node = get_node(str("Scene Objects/", Global.get_island_formatted(id)))
	return island_node
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent):
	if event.is_action_pressed("left") and current_island.next_island_left:
		current_island = current_island.next_island_left 
		plricon.global_position = current_island.global_position
	if event.is_action_pressed("right") and current_island.next_island_right: 
		current_island = current_island.next_island_right
		plricon.global_position = current_island.global_position
		
	if event.is_action_released("accept"):
		if current_island.level_scene:
			current_island.level_scene.parent_island_select = self # When an island icon is selected, it goes to its respective level selection screen. Parent Island Select is a variable in that level selection screen that can be set to any Node. The reason why we set it to this island selection screen is so the level selection screen knows which level we came from. This script adds the level selection screen to its elements. Then it sets the stage to the level selection screen. Finally, the island screen deletes itself to prevent overlapping.
			get_tree().get_root().add_child(current_island.level_scene)
			get_tree().current_scene = current_island.level_scene
			get_tree().get_root().remove_child(self)
