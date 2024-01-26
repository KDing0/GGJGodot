extends ThrowState


@export (PackedScene) var projectile
@export (PackedScene) var projectile2
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "0"
@export  var push_back_amount = "0"
var speed_modifier

@onready var hitbox = $Hitbox

var dir = - 1

func _frame_44():
	host.spawn_object(projectile, host.opponent.get_pos().x, -18, true, {"speed_modifier":0}, false)

func _frame_9():
	host.opponent.set_vel(5 * host.get_opponent_dir(), -3)
	host.opponent.set_pos(host.get_pos().x + (10 * host.get_opponent_dir()),-13)
	
func _frame_10():
	host.opponent.set_vel(5 * host.get_opponent_dir(), -3)


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
