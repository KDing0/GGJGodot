extends CharacterState


const TRACKING_SPEED = "7.0"
const TRACKING_MIN_DIST = "25"

var hit_opponent = false

func _frame_0():
	if host.opponent.current_state().is_hurt_state == true:
		hit_opponent = true
	
func _frame_22():
	if hit_opponent == true:
		var pos = host.obj_local_center(host.opponent)
		var dir = fixed.normalized_vec_times(str(pos.x), str(pos.y+20), "7.0")
		host.apply_force(dir.y, dir.x)
	
func _tick():
	if hit_opponent:
		var pos = host.obj_local_center(host.opponent)
		var dir = fixed.normalized_vec_times(str(pos.x), str(pos.y+20), TRACKING_SPEED)
		host.move_directly(dir.x, dir.y)

func _on_hit_something(obj, hitbox):
	super._on_hit_something(obj, hitbox)
	if obj == host.opponent:
		hit_opponent = true
