extends Button

@export_file("*.tscn") var previous_scene: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		
func _input(event):
	if previous_scene and event.is_action_released("cancel"):
		get_tree().change_scene_to_file(previous_scene)


func _on_button_up():
	if previous_scene:
		get_tree().change_scene_to_file(previous_scene)
