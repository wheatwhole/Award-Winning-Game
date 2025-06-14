extends CharacterBody2D


const what_VELOCITY: float = -350.0 # negative because setting to positive just doesnt work. Probably because y in godot is negative
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_enum("2") var xsize: String
@export_enum("2","3","4","5") var ysize: String
@export var size: String:
	get:
		return str(xsize, "x", ysize)
@export var gravity_multiplier: float = -0.00000980392*what_VELOCITY
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var falling_ground = $"."
@onready var anim = $AnimatedSprite2D

func _ready():
	anim.set_frame_and_progress(Global.get_falling_ground_anim(size),1)
	
func _physics_process(_delta):	
	if not is_on_floor():
		# velocity.x=lerp(prevVelocity.x, velocity.x, 0)
		velocity.y += gravity*gravity_multiplier
		if abs(velocity.y) < 1:
			gravity *=0.95
		else:
			gravity = 4900
	if is_on_floor(): 
		velocity.y -= 450
	move_and_slide()

	
# what caused the constant falling bug was velocity being set to a very high amount at the start of the game. i fixed this by opening the .tscn in Notepad and removing the "velocity = Vector2(0,174810)" line
