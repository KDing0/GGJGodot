extends ThrowState


	
	

func _frame_35():
	host.change_state("WaitShort")	
	host.opponent.change_state("Getup")	
	
func _tick():
	if current_tick >= 34:
		host.apply_force(0, 0)
		host.set_vel(0, 0)
		host.apply_fric()
		host.apply_forces()
		#var pos = host.obj_local_center(host.opponent)
		#host.move_directly(pos.x-25, pos.y)
		host.reset_pushback()
		host.opponent.set_vel(0, 0)
		host.opponent.reset_pushback()
