extends PlayerState

func enter_state(player_node):
	super(player_node)
	print("run")


func handle_input(_delta):
	var dirx = Input.get_axis("left", "right");
	var diry = Input.get_axis("down", "jump");
	if dirx != 0:
		player.velocity.x = move_toward(player.velocity.x, dirx*player.SPEED, player.ACCELERATION)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0 , player.FRICTION)
	
	if abs(player.velocity.x) < 1:
		player.change_state("IdleState")
	
	if Input.is_action_just_pressed("jump") and player.jumps < 1 and player.airtime < 0.15:
		player.change_state("JumpingState")

	elif Input.is_action_just_pressed("dash"):
		player.change_state("DashingState")
	
