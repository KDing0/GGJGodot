extends ThrowState

class_name DivekickHold



@export  var release_Height = 10
@export (PackedScene) var projectile
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "5.0"
@export  var push_back_amount = "-2.0"
@onready var hitbox = $Hitbox


var speed_modifier


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

var release_next_frame = false

func _tick():	
	if current_tick > 1 and host.is_grounded():
		_release()
		activate_hitbox(hitbox)
		queue_state_change("Landing", 10)
		host.opponent.update_facing()
		host.set_vel("-0.2", "0")
		var object = host.spawn_object(projectile, projectile_x+5, projectile_y, true, {"speed_modifier":speed_modifier})
		host.play_sound("IzunaSwish")

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


	
