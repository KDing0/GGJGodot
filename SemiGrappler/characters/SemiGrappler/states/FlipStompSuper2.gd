extends ThrowState

const LIFT_SPEED = - 5
const BACKWARDS_SPEED = 3
const GRAV = "0.9"
const FALL_SPEED = "30"

@export (PackedScene) var projectile
@export (PackedScene) var projectile2
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "5.0"
@export  var push_back_amount = "-2.0"
var speed_modifier

@onready var hitbox = $Hitbox

var dir = - 1
var hitYet = false

func _frame_0():
	hitYet = false

func _tick():	
	if hitYet == false and current_tick > 1 and host.is_grounded():
		hitYet = true
		_release()
		activate_hitbox(hitbox)
		host.opponent.update_facing()
		host.set_vel("-0.2", "0")
		host.spawn_object(projectile, host.opponent.get_pos().x, -18, true, {"speed_modifier":0}, false)
		dir = host.get_opponent_dir()
		host.play_sound("IzunaSwish")
	host.apply_grav_custom(GRAV, FALL_SPEED)
	host.apply_forces_no_limit()


func _exit():
	host.sprite.flip_v = false
	host.opponent.sprite.flip_v = false


