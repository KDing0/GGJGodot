extends Hitbox

@export var cooldown = 10
@export var cooldown_counter = 10
var tickCounter = 0

func tick():
	tickCounter += 1
	cooldown_counter = cooldown_counter +1
	if looping:
		var loop_tick = tick % (loop_active_ticks + loop_inactive_ticks)
		var prev_enabled = enabled
		enabled = loop_tick < loop_active_ticks
		if not enabled and prev_enabled:
			for hitbox in grouped_hitboxes:
				hitbox.hit_objects.clear()
			played_whiff_sound = false
		if enabled and not prev_enabled:
			play_whiff_sound()
	tick += 1
	if tick > active_ticks:
		if not always_on:
			deactivate()
	update()


func hit(obj):
	var state = obj.current_state().state_name
	if obj.is_in_group("Fighter") and (tickCounter > 1 and (state != "HurtGrounded" and state != "HurtAerial") or cooldown_counter < cooldown):
		cooldown_counter = 0
		return
	hit_objects = []
	cooldown_counter = 0
	var camera = get_tree().get_nodes_in_group("Camera3D")[0]
	var dir = get_dir_float(true)
	if grounded_hit_state == "HurtGrounded" and obj.is_grounded():
			dir.y *= 0
	for hitbox in grouped_hitboxes:
		hitbox.hit_objects.append(obj.name)
	obj.hit_by(self.to_data())
	var can_hit = true
	if obj.is_in_group("Fighter"):
		if host.is_in_group("Fighter"):
			host.feinting = false
			host.current_state().feinting = false
		if not host.is_ghost:
			camera.bump(camera_bump_dir, screenshake_amount, Utils.frames(victim_hitlag if screenshake_frames < 0 else screenshake_frames) * float(obj.global_hitstop_modifier))
		if obj.can_parry_hitbox(self) or name in obj.parried_hitboxes:
			can_hit = false
			emit_signal("got_parried")
		if obj.on_the_ground:
			if not hits_otg:
				can_hit = false
		if can_hit and spawn_particle_effect:
			if hit_particle:
				spawn_particle(hit_particle, obj, dir)
			if not replace_hit_particle:
				spawn_particle(HIT_PARTICLE if Global.enable_custom_hit_sparks else DEFAULT_HIT_PARTICLE, obj, dir)

	if can_hit:
		var pushback_modifier = host.fixed.mul(str(host.hitstun_decay_combo_count) if host.is_in_group("Fighter") else "0", COMBO_PUSHBACK_COEFFICIENT)
		var pushback = host.fixed.mul(host.fixed.add(pushback_x, pushback_modifier), "-1")
		pushback = host.fixed.div(pushback, "2")
		host.add_pushback(pushback)
		obj.add_pushback(pushback)
		var opponent = obj.get("opponent")
		
		if opponent:
			if opponent != host:
				opponent.add_pushback(pushback)
		if hit_sound_player and not ReplayManager.resimulating:
			hit_sound_player.play()
			if not bass_on_whiff:
				hit_bass_sound_player.play()
		emit_signal("hit_something", obj, self)
