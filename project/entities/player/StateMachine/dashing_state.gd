extends PlayerState


func enter_state(player_node):
	super(player_node)
	var dirx = Input.get_axis("left", "right");
	var diry = Input.get_axis("down", "jump");
	
func handle_input(delta):
	var axis = player.axis
	if !player.has_dashed:

			
		player.velocity = player.velocity.move_toward(axis.normalized() * player.DASH_SPEED, player.ACCELERATION * player.FRICTION)
		player.is_dashing = true
		player.has_dashed = true

	if player.is_dashing:
		player.dash_time += delta
		if player.dash_time >= player.DASH_DURATION:
			player.dash_time = 0	
			player.change_state("DashEndState")
		
		if player.is_on_floor():
			player.is_dashing = false
			player.change_state("DashEndState")
