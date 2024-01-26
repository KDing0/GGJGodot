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
@export (PackedScene) var particle2
@export var projectile_spawn_frame = 10

var starting_pos = Vector2(0,0)
var dir
var spawnDot = true

var speed_modifier
@export (PackedScene) var projectile3

var rock2
var rock3
var rock4
var rock5
var rock6
var rock7

var clingTarget 

var teleportOver = false

func _frame_0():
	teleportOver = false
	starting_dir = host.get_opponent_dir()
	iasa_at = 9
	backwards_stall_frames = 0
	host.start_throw_invulnerability()
	var comboing = false
	forward = false
	
	rock2 = host.spawn_object(projectile3, -75, -10, true, {"speed_modifier":speed_modifier,"sprite_animation":"1"})
	rock2.apply_force_relative("-0", "-18")
	rock3 = host.spawn_object(projectile3, -35, -10, true, {"speed_modifier":speed_modifier,"sprite_animation":"2"})
	rock3.apply_force_relative("-0", "-16")
	rock4 = host.spawn_object(projectile3, -30, -10, true, {"speed_modifier":speed_modifier,"sprite_animation":"3"})
	rock4.apply_force_relative("-0", "-20")

	rock5 = host.spawn_object(projectile3, 115, -10, true, {"speed_modifier":speed_modifier,"sprite_animation":"4"})
	rock5.apply_force_relative("-0", "-17")
	rock6 = host.spawn_object(projectile3, 75, -10, true, {"speed_modifier":speed_modifier,"sprite_animation":"5"})
	rock6.apply_force_relative("-0", "-15")
	rock7 = host.spawn_object(projectile3, 70, -10, true, {"speed_modifier":speed_modifier,"sprite_animation":"6"})
	rock7.apply_force_relative("-0", "-19")



func _frame_5():
	spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
	host.start_super()
	host.play_sound("Super")
	host.play_sound("Super2")
	host.play_sound("Super3")
		
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
	host.colliding_with_opponent = false
	if clingTarget == null:
		host.apply_fric()
		host.apply_grav()
		host.apply_forces()
		host.set_grounded(host.get_pos().y == 0)	
	if clingTarget != null:
		if teleportOver == false:
			dir = clingTarget.get_pos()
			dir.x = dir.x - host.get_pos().x
			dir.y = dir.y - host.get_pos().y
			host.move_directly(dir.x, dir.y)
			starting_pos = host.get_pos()
		if teleportOver == true:
			dir = clingTarget.get_pos()
			dir.x = dir.x - host.get_pos().x
			dir.y = dir.y - host.get_pos().y
			host.move_directly(dir.x, dir.y+30)
			starting_pos = host.get_pos()
		
func _frame_10():
	if rock6 != null:
		host.set_facing( - host.get_facing_int())
		var obj = rock6
		spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
		dir = obj.get_pos()
		var a = host.get_pos()
		dir.x = dir.x - host.get_pos().x
		dir.y = dir.y - host.get_pos().y
		
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
		clingTarget = obj
		spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/HitRocks.tscn"), Vector2(startDifX, startDifY), Vector2.RIGHT * host.get_facing_int())
		
func _frame_15():
	if rock3 != null:
		host.set_facing( - host.get_facing_int())
		var obj = rock3
		spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
		dir = obj.get_pos()
		var a = host.get_pos()
		dir.x = dir.x - host.get_pos().x
		dir.y = dir.y - host.get_pos().y
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
		clingTarget = obj
	
	
func _frame_20():
	if rock5 != null:
		host.set_facing( - host.get_facing_int())
		var obj = rock5
		spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
		dir = obj.get_pos()
		var a = host.get_pos()
		dir.x = dir.x - host.get_pos().x
		dir.y = dir.y - host.get_pos().y

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
		clingTarget = obj


func _frame_25():
	if rock2 != null:
		host.set_facing( - host.get_facing_int())
		var obj = rock2
		spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
		dir = obj.get_pos()
		var a = host.get_pos()
		dir.x = dir.x - host.get_pos().x
		dir.y = dir.y - host.get_pos().y

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
		clingTarget = obj
	
func _frame_30():
	if rock7 != null:
		host.set_facing( - host.get_facing_int())
		var obj = rock7
		spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
		dir = obj.get_pos()
		var a = host.get_pos()
		dir.x = dir.x - host.get_pos().x
		dir.y = dir.y - host.get_pos().y
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
		clingTarget = obj

func _frame_35():
	if rock4 != null:
		host.set_facing( - host.get_facing_int())
		var obj = rock4
		spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
		dir = obj.get_pos()
		var a = host.get_pos()
		dir.x = dir.x - host.get_pos().x
		dir.y = dir.y - host.get_pos().y
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
		clingTarget = obj

func _frame_45():
	var obj = host.opponent
	spawn_particle_relative(preload("res://SemiGrappler/characters/SemiGrappler/HitEffects/TeleportEffect.tscn"), host.hurtbox_pos_relative_float())
	dir = obj.get_pos()
	var a = host.get_pos()
	dir.x = dir.x - host.get_pos().x
	dir.y = dir.y - host.get_pos().y + 20
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
	clingTarget = obj
	
func _frame_48():
	host.change_state("AirGrabSuper")
