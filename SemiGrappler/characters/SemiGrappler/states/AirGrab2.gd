extends CharacterState


func _frame_8():
	host.apply_force(-8, 0)
	
func _frame_14():
	host.reset_momentum();
	
