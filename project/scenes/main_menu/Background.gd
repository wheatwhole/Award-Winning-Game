extends ParallaxBackground

@onready var cloud1 = $Layer3
@onready var cloud2 = $Layer4
@onready var cloud3 = $Layer5
@export var Scale: bool
#var cloud1scene = preload("res://layer_3.tscn")
#var cloud2scene = preload("res://layer_4.tscn")
#var cloud3scene = preload("res://layer_5.tscn")

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize() # Replace with function body.
	#spawn_dup_cloud()
	if Scale == false:
		for _i in self.get_children():
			_i.motion_scale.x = 1
			_i.motion_scale.y = 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
#
#func spawn_dup_cloud():
	#var cloud1dup = cloud1scene.instantiate()
	#var cloud2dup = cloud2scene.instantiate()
	#var cloud3dup = cloud3scene.instantiate()
	#add_child(cloud1dup)
	#add_child(cloud2dup)
	#add_child(cloud3dup)
	#cloud1dup.position.y = randf_range(0,100)
	#cloud2dup.position.y = randf_range(0,100)
	#cloud3dup.position.y = randf_range(0,100)
	#cloud1dup.motion_scale.x = randf_range(1,1.4)
	#cloud2dup.motion_scale.x = randf_range(1.3,1.5)
	#cloud3dup.motion_scale.x = randf_range(1,4.6)
#
func _on_layer_1_draw():
	if Scale == true:
		cloud1.motion_scale.x = randf_range(1,1.6)
	else:
		cloud1.motion_scale.x = 1
