extends CharacterState


const TRACKING_SPEED = "7.0"
const TRACKING_MIN_DIST = "0"

var hit_opponent = false

func _frame_0():
	hit_opponent = false

func _tick():
	if hit_opponent:
		var pos = host.obj_local_center(host.opponent)
		var pos2 = host.obj_local_center(host)
		if fixed.gt(fixed.vec_len(str(pos.x), str(pos.y)), TRACKING_MIN_DIST):
			var dir = fixed.normalized_vec_times(str(pos.x), str(pos.y), TRACKING_SPEED)
			var dir2 = fixed.normalized_vec_times(str(pos2.x), str(pos2.y), TRACKING_SPEED)
			host.move_directly(dir.x, dir.y)
			host.opponent.move_directly(dir2.x, dir2.y)

func _on_hit_something(obj, hitbox):
	super._on_hit_something(obj, hitbox)
	if obj == host.opponent:
		hit_opponent = true
		
