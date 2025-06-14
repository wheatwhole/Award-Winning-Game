@tool
extends Node
class_name LevelIcon

# "worldwide_level_ID" tells us that level's place out of every single level in the game. "level_name" tells us that levels position on the island. So although the first level of Shattered Savanna is named 1, its worldwide_level_ID would be 4
@export var worldwide_level_ID: int
@export var level_name: String

@export_file("*.tscn") var next_scene_path: String
@export var next_level_up: LevelIcon
@export var next_level_down: LevelIcon
@export var next_level_left: LevelIcon
@export var next_level_right: LevelIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	# $TextureRect.texture = load("res://Pixel Adventure 1/Free/Menu/Levels/" + str(worldwide_level_ID) +".png")
	# Although not being used anymore, the disabled code above can be used to load level icons based off of their worldwide_level_ID. Its better to do this using an array rather than what is above
	$Label.text=level_name
func _process(_delta):
	if Engine.is_editor_hint():
			# $TextureRect.texture = load("res://Pixel Adventure 1/Free/Menu/Levels/" + str(worldwide_level_ID) +".png")
			$Label.text=level_name
