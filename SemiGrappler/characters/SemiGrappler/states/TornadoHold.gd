extends CharacterState

@export (PackedScene) var particle2 = null
@export (PackedScene) var projectile


var proj

const PULL_SPEED = "-5"
const MAX_EXTRA_PULL_DIST = "40"
const MAX_EXTRA_PULL = "-20"
const PULL_FORCE = "-1"
const FIGHTER_PULL_SPEED = "-9"
	

@onready var windbox = $WindBox
@onready var throwbox = $ThrowBox

func _frame_8():
	host.start_throw_invulnerability()

func _frame_13():
	host.start_invulnerability()
	
func _frame_17():	
	host.set_facing(host.get_opponent_dir())
	host.set_vel(8*host.get_opponent_dir(),0)


func _tick():
	if current_tick == 0:
		var pos = particle_position
		pos.x *= host.get_facing_int()
		proj = host.spawn_object(projectile, host.get_pos().x, host.get_pos().y-20, true, {"speed_modifier":0})
		spawn_particle_relative(particle2, pos, Vector2.RIGHT * host.get_facing_int())
	if proj:
		proj.set_pos(host.get_pos().x+10, host.get_pos().y-10)
		
	if current_tick >= 6:
		var wb = windbox
		wb.facing = host.get_facing()
		var pos = host.get_pos()
		wb.update_position(pos.x, pos.y)
		
		var test1 = wb.width 
		var test2 = host.opponent.hurtbox.width
		if wb.overlaps(host.opponent.hurtbox):
			pull_object(host.opponent)






func _exit():
	host.release_opponent()
	if proj:
		proj.disable()

func pull_object(obj):
	var throw_pos = throwbox.get_absolute_position()
	throw_pos.y = 0
	var obj_pos = obj.get_pos()
	var diff = fixed.vec_sub(str(obj_pos.x), str(obj_pos.y), str(throw_pos.x), str(throw_pos.y))
	var length = fixed.vec_len(diff.x, diff.y)
	if obj is Fighter:
		var dir = fixed.normalized_vec_times(diff.x, diff.y, PULL_FORCE)
		obj.apply_force(dir.y, dir.x)

	var dist_ratio = fixed.div(length, MAX_EXTRA_PULL_DIST)
	if fixed.gt(dist_ratio, "1.0"):
		dist_ratio = "1.0"
	
	var extra_pull = fixed.mul(fixed.sub("1.0", dist_ratio), MAX_EXTRA_PULL)
	var total_pull
	if not obj is Fighter:
		total_pull = fixed.add(PULL_SPEED, extra_pull)
	else :
		total_pull = FIGHTER_PULL_SPEED
	if fixed.gt(total_pull, length):
		total_pull = length
	
	var dir = fixed.normalized_vec_times(diff.x, diff.y, total_pull)
	obj.move_directly(dir.x, dir.y)
