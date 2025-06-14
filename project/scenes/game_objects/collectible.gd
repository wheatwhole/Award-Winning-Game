extends Area2D
@onready var level_manager = get_tree().root.find_child("Level Manager", true, false)
@onready var anim = $AnimatedSprite2D
@onready var animplayer = $"AnimationPlayer"
@onready var collision_shape_2d = $CollisionShape2D



@export_group("Layout")

@export_enum("apple", "banana", "melon", "strawberry", "kiwi", "cherry", "orange", "pineapple") var Fruit: String
@export_enum("vertical", "horizontal", "square") var Layout: String
@export var amount: int

@export var fruit_order = { #Parameters for what the fruits should be when spawned in order
"1": "", 
"2": "", 
"3": "", 
"4": "", 
"5": "", 
"6": "",
"7": "",
"8": "",
"9": "",
"10": "",
"11": "",
"12": "",
"13": "",
"14": "",
"15": "",
"16": "",
"17": "",
 }
func dup():
		var duplicate = Global.clone("res://scenes/game_objects/collectible.tscn", self.position)
		return duplicate 
		
func _ready():
	anim.play(Fruit)
	print(Fruit)
	await get_parent().ready
	if Layout == "vertical": 
		for n in range(0,amount,+1):
			var dup = dup()
			self.get_parent().add_child.call_deferred(dup)
			dup.position += Vector2(0, -60*n)
			dup.Fruit = fruit_order[str(n+1)]
		queue_free()
	elif Layout == "horizontal": 
		for n in range(0,amount,+1):
			var dup = dup()
			self.get_parent().add_child.call_deferred(dup)
			dup.position += Vector2(60*n,0)
			dup.Fruit = fruit_order[str(n+1)]
		queue_free()
		
func _process(_delta):
	if Engine.is_editor_hint():
		pass
		
func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		level_manager.add_point()
		anim.play("collected")
		await anim.animation_finished
		queue_free()
