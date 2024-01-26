extends ThrowState

class_name ThrowState3CC


func update_throw_position():
	var frame = host.get_current_sprite_frame()
	if frame in throw_positions:
		var pos = throw_positions[frame]
		host.throw_pos_x = pos.x
		host.throw_pos_y = pos.y

func _frame_0():
	host.opponent.change_state("Grabbed")
	host.throw_pos_x = start_throw_pos_x
	host.throw_pos_y = start_throw_pos_y
	var throw_pos = host.get_global_throw_pos()
	host.opponent.set_pos(throw_pos.x, throw_pos.y)

func _tick_shared():
	if current_tick == 0:
		throw = true





		if reverse:
			host.set_facing( - host.get_facing_int())
		host.start_invulnerability()
		released = false
	super._tick_shared()
	if release and current_tick + 1 == release_frame:
		_release()
		released = true
	if not released:
		host.opponent.colliding_with_opponent = false
		host.colliding_with_opponent = false
	update_throw_position()

func _tick_after():
	super._tick_after()
	if not released:
		host.update_data()
		var throw_pos = host.get_global_throw_pos()
		host.opponent.set_pos(throw_pos.x, throw_pos.y)

func _exit():
	released = false

func _release():
	throw = false
	host.throw_pos_x = release_throw_pos_x
	host.throw_pos_y = release_throw_pos_y
	var pos = host.get_global_throw_pos()
	host.opponent.set_pos(pos.x, pos.y)
	host.opponent.update_facing()
	var throw_data = HitboxData.new(self)
	host.opponent.hit_by(throw_data)
	if increment_combo:
		host.incr_combo()
	if screenshake_amount > 0 and screenshake_frames > 0 and not host.is_ghost:
		var camera = get_tree().get_nodes_in_group("Camera3D")[0]
		camera.bump(Vector2(), screenshake_amount, screenshake_frames / 60.0)
