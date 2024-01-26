extends CharacterState

@export  var speed = "4"
const Y_MODIFIER = "1"

func _frame_0():
	throw_techable = false
	
func _frame_1():
	if data != null:
		spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(data.x, data.y))
		var force = xy_to_dir(data.x, data.y, speed)
		host.apply_force(fixed.mul(force.y, Y_MODIFIER) if "-" in force.y else force.y, force.x)
	
func _frame_4():
	host.end_invulnerability()
	
func _frame_9():
	throw_techable = false

func _tick():
	host.apply_fric()
	host.apply_grav()
	host.apply_forces()
