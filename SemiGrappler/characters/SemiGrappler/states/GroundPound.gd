extends ThrowState

const LIFT_SPEED = 0
const BACKWARDS_SPEED = 0
const GRAV = "0.9"
const FALL_SPEED = "0"

@export (PackedScene) var projectile
@export (PackedScene) var projectile2
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "0"
@export  var push_back_amount = "0"
var speed_modifier

@onready var hitbox = $Hitbox

var dir = - 1

@export  var super_level = 3
@export  var supers_used = - 3
@export  var super_freeze_ticks = 15
@export  var super_effect = true


func process_hitboxes():
	if hitbox_start_frames.has(current_tick + 1):
		for hitbox in hitbox_start_frames[current_tick + 1]:
			activate_hitbox(hitbox)
			if hitbox is Hitbox:
				if hitbox.hitbox_type == Hitbox.HitboxType.ThrowHit or hitbox.hitbox_type == Hitbox.HitboxType.Normal:
					hitbox.hit(host.opponent)
					hitbox.deactivate()
	for hitbox in get_active_hitboxes():
		hitbox.facing = host.get_facing()
		if hitbox.active:
			hitbox.tick()
		else :
			deactivate_hitbox(hitbox)

func is_usable():
	return super.is_usable() and host.supers_available >= super_level

func _enter_shared():
	super._enter_shared()
	if super_effect:
		host.start_super()
		host.play_sound("Super")
		host.play_sound("Super2")
		host.play_sound("Super3")
	for i in range(super_level if supers_used == - 1 else supers_used):
		host.use_super_bar()
	host.opponent.change_state("Knockdown")

func _frame_11():
	host.spawn_object(projectile2, -50, -20, true, {"speed_modifier":0,"sprite_animation":"default","z":1,"life":160})
	host.spawn_object(projectile2, 50, -20, true, {"speed_modifier":0,"sprite_animation":"default","z":1,"flip":-1,"life":160})

func _frame_20():
	host.spawn_object(projectile2, -65, -25, true, {"speed_modifier":0,"sprite_animation":"default","z":-1,"life":132})
	host.spawn_object(projectile2, 65, -25, true, {"speed_modifier":0,"sprite_animation":"default","flip":-1,"z":-1,"life":132})

func _frame_29():
	host.spawn_object(projectile2, -35, -8, true, {"speed_modifier":0,"sprite_animation":"default","z":2,"life":107})
	host.spawn_object(projectile2, 35, -8, true, {"speed_modifier":0,"sprite_animation":"default","flip":-1,"z":2,"life":107})

func _frame_37():
	host.spawn_object(projectile2, -50, -20, true, {"speed_modifier":0,"sprite_animation":"2","flip":-1,"z":2,"life":79})
	host.spawn_object(projectile2, 50, -20, true, {"speed_modifier":0,"sprite_animation":"2","flip":1,"z":2,"life":79})


func _frame_57():
	host.spawn_object(projectile2, -80, -10, true, {"speed_modifier":0,"sprite_animation":"3","flip":-1,"z":2,"life":39})
	host.spawn_object(projectile2, 80, -10, true, {"speed_modifier":0,"sprite_animation":"3","flip":1,"z":2,"life":39})
	host.spawn_object(projectile2, 0, -60, true, {"speed_modifier":0,"sprite_animation":"4","flip":1,"z":-2,"life":39})
	
func _frame_55():
	host.opponent.change_state("Knockdown")

func _frame_53():
	host.opponent.change_state("Knockdown")
	
func _frame_41():	
	host.start_super()
	host.play_sound("Super")
	host.play_sound("Super2")
	host.play_sound("Super3")
	
func _frame_59():
	host.apply_force(0, 0)
	host.set_vel(0, 0)

func _frame_0():
	host.z_index = 1
	
	host.throw_pos_x = start_throw_pos_x
	host.throw_pos_y = start_throw_pos_y
	var throw_pos = host.get_global_throw_pos()
	host.opponent.set_pos(throw_pos.x, throw_pos.y)
	


func _tick():
	if current_tick >= 8:
		dir = - 1

	

func _exit():
	host.sprite.flip_v = false
	host.opponent.sprite.flip_v = false
	host.reset_pushback()
