extends ThrowState

const LIFT_SPEED = - 5
const BACKWARDS_SPEED = 3
const GRAV = "0.9"
const FALL_SPEED = "30"

@export (PackedScene) var projectile
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "5.0"
@export  var push_back_amount = "-2.0"
var speed_modifier

@onready var hitbox = $Hitbox

var dir = - 1

func _frame_0():
	host.apply_force_relative( - BACKWARDS_SPEED, LIFT_SPEED)
	host.move_directly(0, - 1)
	host.z_index = 1
	host.opponent.sprite.flip_v = true
	host.throw_pos_x = start_throw_pos_x
	host.throw_pos_y = start_throw_pos_y
	var throw_pos = host.get_global_throw_pos()
	host.opponent.set_pos(throw_pos.x, throw_pos.y)
	

func _tick():
	if current_tick >= 8:
		host.sprite.animation = "RKOtwo"
		sprite_animation = "RKOtwo"
		
	if current_tick > 1 and host.is_grounded():
		host.sprite.animation = "RKOtwo"
		sprite_animation = "RKOtwo"
		_release()
		activate_hitbox(hitbox)
		spawn_particle_relative(particle_scene)
		queue_state_change("Landing", 28)
		host.opponent.update_facing()
		host.set_vel("-0.2", "0")
		var object = host.spawn_object(projectile, projectile_x+5, projectile_y, true, {"speed_modifier":speed_modifier})
		var object2 = host.spawn_object(projectile, projectile_x*-1+5, projectile_y, true, {"speed_modifier":speed_modifier})
		object2.sprite.flip_h = true
		dir = host.get_opponent_dir()
		host.play_sound("IzunaSwish")

	host.apply_grav_custom(GRAV, FALL_SPEED)
	host.apply_forces_no_limit()
	

func _exit():
	host.sprite.flip_v = false
	host.opponent.sprite.flip_v = false



	
