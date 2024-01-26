extends CharacterState

@export  var speed = "8.5"
@export  var accel_speed = "0.7"
@export  var tech = false

var force
var accel


func _enter():
#	force = xy_to_dir(data.x, 0, speed, "1")
#	accel = xy_to_dir(data.x, 0, accel_speed, "1")
#	if "-" in force.x:
#		if host.get_facing() == "Left":
#			anim_name = "3CRoll"
#		else :
#			anim_name = "3CRollB"
#			force = xy_to_dir(data.x, 0, "0.01", "0.01")
#			accel = xy_to_dir(data.x, 0, "0.01", "0.01")
#	else :
#		if host.get_facing() == "Left":
#			anim_name = "3CRollB"
#			force = xy_to_dir(data.x, 0, "0.01", "0.01")
#			accel = xy_to_dir(data.x, 0, "0.01", "0.01")
#		else :
#			anim_name = "3CRoll"
	host.apply_force(str(0), "20")

		
func _frame_8():
	if not tech:
		host.end_invulnerability()
		host.end_throw_invulnerability()

func _tick():
	if accel:
		host.apply_force(str(0), accel.x)
		host.apply_fric()
		host.apply_forces()
