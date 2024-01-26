extends CharacterState



func _frame_0():
	host.start_invulnerability()
	
func _tick():
	host.apply_force(0, 0)
	host.set_vel(0, 0)
	host.apply_fric()
	host.apply_forces()
	var pos = host.obj_local_center(host.opponent)
	host.move_directly(pos.x-25, pos.y)
