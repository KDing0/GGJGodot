extends CharacterState

const MOVE_DIST = "175"
const BACKWARDS_STALL_FRAMES = 5
const BACKWARDS_STALL_FRAMES_NEUTRAL_EXTRA = 5
const UPWARDS_STALL_FRAMES_NEUTRAL_EXTRA = 5
const EXTRA_FRAME_PER = "1000"
const EXTRA_FRAME_IN_COMBOS = 4
const EXTRA_FRAME_PER_BACKWARDS = "0.2"
const MOMENTUM_FORCE = "1.0"
const CROSS_THROUGH_RECOVERY = 8
const FORWARD_SUPER = 55

var backwards_stall_frames = 0
var starting_dir = 0
var extra_frames = 0
var in_place = false
var forward = false
var x_dist = "0"
@export (PackedScene) var projectile2
@export (PackedScene) var RedDot
@export (PackedScene) var particle2 = null
@export var projectile_spawn_frame = 10

var starting_pos = Vector2(0,0)
var dir
var spawnDot = true

func _frame_0():
	starting_dir = host.get_opponent_dir()
	iasa_at = 9
	backwards_stall_frames = 0
	host.start_throw_invulnerability()
	var comboing = false
	forward = false
	var scaled = xy_to_dir(data.x, data.y)
	in_place = fixed.lt(fixed.vec_len(scaled.x, scaled.y), "0.1")
	x_dist = fixed.abs(scaled.x)
	dir = xy_to_dir(data.x, data.y, MOVE_DIST)
	

func _frame_1():
	starting_pos = host.get_pos()
	
func _frame_4():
	host.end_throw_invulnerability()
	if in_place:
		host.start_invulnerability()
	host.start_projectile_invulnerability()
	host.colliding_with_opponent = false




func _frame_7():
	host.end_invulnerability()
	host.end_projectile_invulnerability()
	host.colliding_with_opponent = true

func _tick():
	if current_tick > 4:
		dir = xy_to_dir(data.x, data.y, MOVE_DIST)
		if spawnDot:
			var redDot = host.spawn_object(RedDot, int(dir.x), int(dir.y), false, {}, true)
			if current_tick == projectile_spawn_frame:
				for obj in host.objs_map.values():
					if obj == null or obj.disabled:
						continue
					if "rockJump" in obj:
						if obj.rockJump == true and redDot.hurtbox.overlaps(obj.hurtbox) and obj != host.clingTarget:
							spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
							dir = obj.get_pos()
							var a = host.get_pos()
							dir.x = dir.x - host.get_pos().x
							dir.y = dir.y - host.get_pos().y
							host.move_directly(dir.x, dir.y)
							host.update_data()
							var b = host.get_pos()
							var vect = Vector2(dir.x,dir.y)
							var angle = rad_to_deg(vect.angle())
							var length = vect.length()
							var object = host.spawn_object(projectile2, starting_pos.x, starting_pos.y, false, {"angle":angle, "length":length}, false)
							var startDifX = starting_pos.x - host.get_pos().x 
							var startDifY = starting_pos.y - host.get_pos().y 
							spawn_particle_relative(particle2, Vector2(startDifX, startDifY), Vector2.RIGHT * host.get_facing_int())
							spawn_particle_relative(particle2, Vector2(startDifX*0.75, startDifY*0.75), Vector2.RIGHT * host.get_facing_int())
							spawn_particle_relative(particle2, Vector2(startDifX*0.5, startDifY*0.5), Vector2.RIGHT * host.get_facing_int())
							spawn_particle_relative(particle2, Vector2(startDifX*0.25, startDifY*0.25), Vector2.RIGHT * host.get_facing_int())
							spawn_particle_relative(particle2, Vector2(0, 0), Vector2.RIGHT * host.get_facing_int())
							object.angle = angle
							object.length = max(length*1 - 30,0)
							#spawnDot = false
							host.clingTarget = obj
							_exit()
							host.change_state("RockJumpCling")
							
							break
		host.apply_fric()
		host.apply_grav()
		host.apply_forces()
		host.set_grounded(host.get_pos().y == 0)	



