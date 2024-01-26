extends CharacterState


const TRACKING_SPEED = "10.0"
const TRACKING_MIN_DIST = "2"

var hit_opponent = true

func _frame_0():
	if host.opponent.current_state().is_hurt_state == true:
		hit_opponent = true

func _tick():
	if hit_opponent:
		var pos = host.obj_local_center(host.opponent)
		var dir = fixed.normalized_vec_times(str(pos.x-15), str(pos.y-10), TRACKING_SPEED)
		host.move_directly(dir.x, dir.y)

func _on_hit_something(obj, hitbox):
	super._on_hit_something(obj, hitbox)
	if obj == host.opponent:
		hit_opponent = true
