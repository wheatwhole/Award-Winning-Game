extends PlayerState


func enter_state(player_node):
	super(player_node)
	player.is_dashing = true
	player.can_dash = false
	player.dash_direction = player.get_direction_from_input()
	player.dash_timer.start(player.dash_length)
	

func handle_input(delta):
	if player.is_dashing:
		player.velocity = player.dash_direction * 10 * delta
