extends CharacterState

func _enter():
	if data.x * host.get_opponent_dir() < 0:
		return "ShortDashBackward"
	else :
		return "ShortDashForward"

func is_usable():
	return super.is_usable() and host.current_state().state_name != "WhiffInstantCancel"
