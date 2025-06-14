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
const DASH_SPEED: int = 500 # speed of the dash
const END_DASH_SPEED: int = 330 # speed the player moves after the dash; momentum

const DASH_DURATION: float = 0.25 # time in seconds for dash to last
const DASH_PAUSE_DURATION: float = 0.25
var dash_time = 0
var dash_pause_time = 0
var is_dashing: bool = false;
var has_dashed: bool = false;
var dash_cooldown_time = 0.0

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


	
func _process(delta: float) -> void:	
	get_input_axis()
	dirx = Input.get_axis("left", "right")
	diry = Input.get_axis("jump", "down")
	
	if dirx != 0:
		last_facing_dirx = dirx
	
	if diry != 0:
		last_facing_diry = diry
	
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
			
	if !is_dashing:
		velocity.y += gravity * delta
		
	if is_on_floor() && velocity.y > 0:
		has_dashed = false
		
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

		
func get_input_axis():
	
	axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("jump"))
	axis = axis.normalized()

	if not axis.x == 0 and not axis.y == 0:
		previous_axis = axis
	
func _on_coyote_timer_timeout():
	coyote = false
