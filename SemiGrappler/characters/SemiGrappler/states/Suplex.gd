extends CharacterState

const MIN_AIRDASH_HEIGHT = 0
const Y_MODIFIER = "1"
const X_MODIFIER = "1.4"
@export  var dir_x:String = "1.0"
@export  var dir_y:String = "0.0"
@export  var speed = "2.0"
@export  var fric = "0.00"

func _frame_0():
	if data != null:
		spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(data.x, data.y))
		var force = xy_to_dir(data.x, data.y, speed)
		host.apply_force(fixed.mul(force.y, Y_MODIFIER) if "-" in force.y else force.y, fixed.mul(force.x, X_MODIFIER))

func _tick():
	
	host.apply_x_fric(fric)
	host.apply_forces_no_limit()
