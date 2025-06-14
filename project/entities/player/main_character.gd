extends CharacterBody2D


var jumping: float = 0
const SPEED: float = 170
const JUMP_VELOCITY: float = -350.0 # negative because setting to positive just doesnt work. Probably because y in godot is negative
var ACCELERATION: float = 20
var FRICTION: float = 1666
var gravity

# physical nodes
@onready var player = $"."
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

# timers
@onready var coyote_timer = $CoyoteTimer
var coyote_frames = 600 
var coyote = false  
var last_floor = false  
var airtime: float = 0.0
var jumps: int = 0

# dashing
@export var dash_speed = 1000
@export var dash_length = 0.2
var is_dashing : bool = false
var can_dash : bool = true
var dash_direction : Vector2

@onready var dash_timer = $DashTimer
# better states
var current_state
var last_facing_dirx = 1  # 1 = right, -1 = left, default is right
var last_facing_diry = 1
var dirx = 1
var diry = 1
var axis = Vector2()
var previous_axis = Vector2()

var jump_buffer_timer: float = 0
func _ready():
	coyote_timer.wait_time = coyote_frames / 60.0
	animation_player.play("land")
	change_state("IdleState")
	

func _on_dash_timer_timeout() -> void:
	is_dashing = false # Replace with function body.

	
func _process(delta: float) -> void:	
	
	
	if current_state:
		current_state.handle_input(delta)
		
	move_and_slide()
	handle_landing()
	
	if dirx == 1:
		sprite_2d.flip_h = false
	elif dirx == -1:
		sprite_2d.flip_h = true
	elif last_facing_dirx == 1:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true
	
	
	#if is_dashing:
		#gravity = 0
	#else:
		#velocity.y += gravity*gravity_multiplier
		#gravity = 4900
		#
	#if not is_on_floor() and !is_dashing:
		## velocity.x=lerp(prevVelocity.x, velocity.x, 0)
		#if abs(velocity.y) < 1:
			#gravity *=0.95
		#else:
			#gravity = 4900
	gravity = Global.DEFAULT_GRAVITY
	
	if not is_on_floor():
		if abs(velocity.y) < 1:
			gravity *=0.95
		else:
			gravity = Global.DEFAULT_GRAVITY
			
	velocity.y += gravity * delta
		
	if !player == null and Input.is_action_just_released("jump"):
		if $RightOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$LeftOuter.is_colliding():
				player.global_position.x += 7
				
		elif $LeftOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$RightOuter.is_colliding():
				player.global_position.x -= 7

	airtime += delta
	if is_on_floor():
		airtime = 0.0
		jumps = 0
		

func change_state(new_state_name: String):
	if current_state:
		current_state.exit_state() # exit current state
	current_state = get_node(new_state_name) # chj
	if current_state: # ensure new state exists
		current_state.enter_state(self) # enter new state
		
func apply_movement() -> void:
	var dirx = Input.get_axis("left", "right")
	var diry = Input.get_axis("jump", "down")
	
	#if !is_dashing:
		#if dirx:
			#velocity.x = move_toward(velocity.x, dirx*SPEED, ACCELERATION)
		#else:
			#velocity.x = move_toward(velocity.x, 0 , FRICTION)

			
func handle_landing(): 
#	was_in_air = not is_on_floor()
#	was_on_floor = is_on_floor()
#	just_landed = is_on_floor() and was_in_air
#	just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0

#	if just_left_ledge:
	#	coyote_timer.start()
	
#	if just_landed:
#		animation_player.play("land")
#		sprite_2d.animation = "land"
	
#	if coyote_timer.time_left > 0:
#		print("coyote", coyote_timer.time_left)

	last_floor = is_on_floor()
	
	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		coyote_timer.start()
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		change_state("JumpingState")

		
func get_direction_from_input():
	var move_dir = Vector2()
	move_dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move_dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("jump"))

	move_dir = move_dir.limit_length(1)
	
	if move_dir == Vector2(0,0):
		if(sprite_2d.flip_h):
			move_dir.x = -1
		else: 
			move_dir.x = 1
	
	return move_dir * dash_speed
	
func _on_coyote_timer_timeout():
	coyote = false
