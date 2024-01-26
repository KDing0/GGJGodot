extends CharacterState

@export (PackedScene) var projectile
@export (PackedScene) var projectile2
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "5.0"
@export  var push_back_amount = "-2.0"
@export var projectile_spawn_frame = 10
var speed_modifier = 10

@export  var super_level = 3
@export  var supers_used = - 3
@export  var super_freeze_ticks = 15
@export  var super_effect = true

var tick_counter = 0
var tick_trigger = 4

func is_usable():
	return super.is_usable() and host.supers_available >= super_level

func _enter_shared():
	super._enter_shared()
	if super_effect:
		host.start_super()
		host.play_sound("Super")
		host.play_sound("Super2")
		host.play_sound("Super3")
	for i in range(super_level if supers_used == - 1 else supers_used):
		host.use_super_bar()
	
func _tick():
	if current_tick == projectile_spawn_frame:
		var rock2 = host.spawn_object(projectile, -45, -10, true, {"speed_modifier":speed_modifier,"sprite_animation":"1"})
		rock2.apply_force_relative("-0", "-16")
		var rock1 = host.spawn_object(projectile, -60, -20, true, {"speed_modifier":speed_modifier,"sprite_animation":"2"})
		rock1.apply_force_relative("-3.5", "-15")
		var rock3 = host.spawn_object(projectile, -20, -50, true, {"speed_modifier":speed_modifier,"sprite_animation":"3"})
		rock3.apply_force_relative(-1, -15)
		var rock5 = host.spawn_object(projectile, 45, -48, true, {"speed_modifier":speed_modifier,"sprite_animation":"5"})
		rock5.apply_force_relative(0, -15)
		var rock4 = host.spawn_object(projectile, 26, -54, true, {"speed_modifier":speed_modifier,"sprite_animation":"4"})
		rock4.apply_force_relative("-1.2", "-15.2")
		var rock6 = host.spawn_object(projectile, 80, -25, true, {"speed_modifier":speed_modifier,"sprite_animation":"6"})
		rock6.apply_force_relative(3, -15)
		var rock7 = host.spawn_object(projectile, 38, -22, true, {"speed_modifier":speed_modifier,"sprite_animation":"7"})
		rock7.apply_force_relative(0, -15)
		var rock8 = host.spawn_object(projectile, 50, -5, true, {"speed_modifier":speed_modifier,"sprite_animation":"8"})
		rock8.apply_force_relative(0, -15)
		var rock9 = host.spawn_object(projectile, -15, -5, true, {"speed_modifier":speed_modifier,"sprite_animation":"9"})
		rock9.apply_force_relative("1.2", "-15.7")
		var rock10 = host.spawn_object(projectile, 80, -0, true, {"speed_modifier":speed_modifier,"sprite_animation":"10"})
		rock10.apply_force_relative("4.2", "-14.7")
		var rock11 = host.spawn_object(projectile, -80, -0, true, {"speed_modifier":speed_modifier,"sprite_animation":"11"})
		rock11.apply_force_relative("-3.2", "-14.7")
		var object2 = host.spawn_object(projectile2, 20, -50, true, {"speed_modifier":speed_modifier})
