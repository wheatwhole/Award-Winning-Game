extends Panel
class_name Points

@onready var label: Node = $Label
@export var points: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str("points - ", points)
func _process(_delta):
	if Engine.is_editor_hint():
			label.text = str("points - ", points)
