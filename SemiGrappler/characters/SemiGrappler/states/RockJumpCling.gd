extends CharacterState

func _tick():
	if host.clingTarget != null:
		host.air_movements_left = 1
		var dir = host.clingTarget.get_pos()
		var a = host.get_pos()
		dir.x = dir.x - host.get_pos().x
		dir.y = dir.y - host.get_pos().y
		host.move_directly(dir.x, dir.y)
		host.update_data()
		host.reset_pushback()
