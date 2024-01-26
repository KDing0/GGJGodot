extends DefaultFireball




func _enter_shared():
	if reset_momentum:
		host.reset_momentum()
	current_tick = - 1
	current_real_tick = - 1
	start_tick = host.current_tick
	if enter_sfx_player and not ReplayManager.resimulating:
		enter_sfx_player.play()
	emit_signal("state_started")
	if data and data.has("sprite_animation"):
		anim_name = data["sprite_animation"]
		sprite_animation = data["sprite_animation"]
	if data and data.has("flip"):
		host.set_facing(data["flip"])
	if data and data.has("z"):
		host.z_index = (data["z"])
	if data and data.has("life"):
		lifetime = (data["life"])
