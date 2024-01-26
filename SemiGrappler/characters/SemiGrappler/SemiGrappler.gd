extends Fighter

var clingTarget

#
#func hit_by(hitbox):
#	if parried:
#		return 
#	if hitbox.name in parried_hitboxes:
#		return 
#	if not hitbox.hits_otg and is_otg():
#		return 
#	if not hitbox.hits_vs_dizzy and current_state().state_name == "HurtDizzy":
#		return 
#	if hitbox.throw and not is_otg():
#		return thrown_by(hitbox)
#	if not can_parry_hitbox(hitbox):
#
#		match hitbox.hitbox_type:
#			Hitbox.HitboxType.Normal:
#				launched_by(hitbox)
#			Hitbox.HitboxType.Burst:
#				launched_by(hitbox)
#			Hitbox.HitboxType.Flip:
#				set_facing(get_facing_int() * - 1, true)
#				var vel = get_vel()
#				set_vel(fixed.mul(vel.x, "-1"), vel.y)
#				for hitbox in hitboxes:
#					hitbox.facing = get_facing()
#					pass
#				emit_signal("got_hit")
#				take_damage(hitbox.get_damage(), hitbox.minimum_damage)
#			Hitbox.HitboxType.ThrowHit:
#				emit_signal("got_hit")
#				take_damage(hitbox.get_damage(), hitbox.minimum_damage)
#				opponent.incr_combo()
#			Hitbox.HitboxType.OffensiveBurst:
#				opponent.hitstun_decay_combo_count = 0
#				opponent.combo_proration = Utils.int_min(opponent.combo_proration, 0)
#				launched_by(hitbox)
#				reset_pushback()
#				opponent.reset_pushback()
#	else :
#		opponent.got_parried = true
#
#		var host = objs_map[hitbox.host]
#		var projectile = not host.is_in_group("Fighter")
#		var perfect_parry
#		if not projectile:
#			perfect_parry = current_state().can_parry and (always_perfect_parry or opponent.current_state().feinting or opponent.feinting or (initiative and not blocked_last_hit) or parried_last_state)
#			opponent.feinting = false
#			opponent.current_state().feinting = false
#		else :
#
#			perfect_parry = current_state().can_parry and (always_perfect_parry or host.always_parriable or parried_last_state or (current_state().current_tick < PROJECTILE_PERFECT_PARRY_WINDOW and host.has_projectile_parry_window))
#		if perfect_parry:
#			parried_last_state = true
#		else :
#			blocked_last_hit = true
#
#		parried = true
#
#		hitlag_ticks = 0
#		parried_hitboxes.append(hitbox.name)
#		var particle_location = current_state().get("particle_location")
#		particle_location.x *= get_facing_int()
#
#		if not particle_location:
#			particle_location = hitbox.get_overlap_center_float(hurtbox)
#		var parry_meter = PARRY_METER if hitbox.parry_meter_gain == - 1 else hitbox.parry_meter_gain
#
#		current_state().parry(perfect_parry)
#		if not perfect_parry:
#			take_damage(hitbox.damage / PARRY_CHIP_DIVISOR)
#			apply_force_relative(fixed.div(hitbox.knockback, fixed.mul(PARRY_KNOCKBACK_DIVISOR, "-1")), "0")
#			gain_super_meter(parry_meter / 3)
#			opponent.gain_super_meter(parry_meter / 3)
#			if not projectile:
#				current_state().anim_length = opponent.current_state().anim_length
#				current_state().endless = opponent.current_state().endless
#				if not "fixedRecovery" in current_state() or not current_state().fixedRecovery == true:
#					current_state().iasa_at = opponent.current_state().iasa_at
#
#
#
#
#			spawn_particle_effect(preload("res://fx/FlawedParryEffect.tscn"), get_pos_visual() + particle_location)
#			parried = false
#			play_sound("Block")
#			play_sound("Parry")
#		else :
#			if projectile:
#				if host.has_method("on_got_parried"):
#					host.on_got_parried()
#			gain_super_meter(parry_meter)
#			spawn_particle_effect(preload("res://fx/ParryEffect.tscn"), get_pos_visual() + particle_location)
#			play_sound("Parry2")
#			play_sound("Parry")
#			emit_signal("parried")
#
#func parry_effect(location, absolute = false):
#	if not absolute:
#		spawn_particle_effect(preload("res://fx/ParryEffect.tscn"), get_pos_visual() + location)
#	else :
#		spawn_particle_effect(preload("res://fx/ParryEffect.tscn"), location)
#	play_sound("Parry2")
#	play_sound("Parry")
