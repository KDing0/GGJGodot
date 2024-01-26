extends ThrowState


@export (PackedScene) var projectile
@export (PackedScene) var projectile2
@export  var projectile_x = 16
@export  var projectile_y = - 16
@export  var speed_modifier_amount = "0"
@export  var push_back_amount = "0"
var speed_modifier

@onready var hitbox = $Hitbox

var dir = - 1


func _frame_9():
	host.set_vel("0", "0")
	host.opponent.set_vel("0.9", "-7")
	host.opponent.set_pos(host.get_pos().x + (10 * host.get_opponent_dir()),-13)
	
func _frame_10():
	host.opponent.set_vel("0.9", "-7")


