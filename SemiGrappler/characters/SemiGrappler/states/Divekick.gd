extends CharacterState

const MIN_AIRDASH_HEIGHT = 0
const Y_MODIFIER = "4"
@export  var dir_x:String = "1.0"
@export  var dir_y:String = "0.0"
@export  var speed = "1.0"
@export  var fric = "0.00"

#onready var throwbox = $ThrowBox

func _frame_8():
	if data != null:
		spawn_particle_relative(preload("res://fx/DashParticle.tscn"), host.hurtbox_pos_relative_float(), Vector2(data.x, data.y))
		var force = xy_to_dir(data.x, data.y+10, speed)
		host.apply_force(fixed.mul(1, Y_MODIFIER) if "-" in force.y else force.y, force.x)
func _tick():
	
	host.apply_x_fric(fric)
	host.apply_forces_no_limit()

#func _on_hit_something(obj, hitbox):
#	._on_hit_something(obj, hitbox)
	#if obj == host.opponent:
		#activate_hitbox(throwbox)
