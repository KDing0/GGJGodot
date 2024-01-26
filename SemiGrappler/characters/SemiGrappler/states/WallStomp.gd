extends CharacterState

@export (PackedScene) var projectile
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "5.0"
@export  var push_back_amount = "-2.0"
@export var projectile_spawn_frame = 10
var speed_modifier = 0

func _tick():
	if current_tick == projectile_spawn_frame:
		var object = host.spawn_object(projectile, data.x*0.6+30, projectile_y, true)
