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
	
func _tick():	
	if current_tick > 1 and host.is_grounded():
		_release()
		activate_hitbox(hitbox)
		queue_state_change("Landing", 28)
		host.opponent.update_facing()
		host.set_vel("-0.2", "0")
		var object = host.spawn_object(projectile, projectile_x+5, projectile_y, true, {"speed_modifier":speed_modifier})
		var object2 = host.spawn_object(projectile, projectile_x*-1+5, projectile_y, true, {"speed_modifier":speed_modifier})
		object2.sprite.flip_h = true
		dir = host.get_opponent_dir()
		host.play_sound("IzunaSwish")

	if current_tick < 14:
		host.apply_grav_custom(GRAV, "10")
	if current_tick >= 14:
		host.apply_grav_custom(GRAV, FALL_SPEED)
	host.apply_forces_no_limit()
	

func _exit():
	host.sprite.flip_v = false
	host.opponent.sprite.flip_v = false


