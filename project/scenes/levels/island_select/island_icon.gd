extends Control
class_name IslandIcon

@export var island_ID: int = 0 # In godot's arrays, 0 represents the first item and 1 represents the second and so on.
@export var next_island_up: IslandIcon
@export var next_island_down: IslandIcon
@export var next_island_left: IslandIcon
@export var next_island_right: IslandIcon
@export var level_scene_packed: PackedScene = load("res://scenes/levels/cloud forest/level.tscn")
@onready var level_scene: Node = level_scene_packed.instantiate()
# To get variables from loaded scenes, a packed scene is used
# @export var level_select_packed: PackedScene = load("res://scenes/level_select/cloud_forest/level_select.tscn")
# @onready var level_select_scene: LevelSelect = level_select_packed.instantiate()
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
	print(level_scene)

	
func _process(_delta):
		$Label.text=Global.get_island_formatted(island_ID)
