extends BaseProjectile

var rockJump = true
@onready var sprite1 = $Sprite1
@onready var sprite2 = $Sprite2
@onready var sprite3 = $Sprite3
@onready var sprite4 = $Sprite4

var angle = 0
var length = 1

func _init():
	flip = $Flip
	
	
func _ready():
	_body = sprite3
	_end = sprite4
	beam_size_x = 1
	sprite.visible = false
	sprite3.visible = false
	sprite2.visible = false
	sprite4.visible = false
	_set_beam_size_x(beam_size_x)
	
func disable():
	sprite.hide()
	sprite3.hide()
	sprite2.hide()
	sprite4.hide()
	disabled = true
	for hitbox in get_active_hitboxes():
		hitbox.deactivate()
	stop_particles()


var _body = null
var _body_width
@export var region_rect_x = 0.0: set = _set_region_rect_x

func tick():
	sprite.visible = true
	sprite3.visible = true
	sprite2.visible = true
	sprite4.visible = true
	rotation_degrees = angle
	_set_beam_size_x(length)
	if current_tick <= 0:
		update_data()
	if hitlag_ticks > 0:
		hitlag_ticks -= 1
	else :
		normal_tick()
	update_collision_boxes()
	update_data()
	_end = sprite4
	#rotation_degrees += deg2rad(60)
	_set_beam_size_x(beam_size_x)
		
func _set_region_rect_x(value):
	region_rect_x = value
	_update_body_region_rect_x()

func _update_body_region_rect_x():
	if(_body != null):
		_body_width = _body.get_texture().get_width()
		var rect = _body.get_region_rect()
		rect = Rect2 ( rect.position.x, rect.position.y, region_rect_x * _body_width, rect.size[1] ) 
		_body.set_region_rect(rect)
		
@export var beam_size_x = 1.0: set = _set_beam_size_x
var _end = null
func _set_beam_size_x(value):
	beam_size_x = value
	_update_body_width()
	_update_end_position()

func _update_body_width():
	if(_body != null):
		var rect = _body.get_region_rect()
		rect.size[0] = beam_size_x
		_body.set_region_rect(rect)

func _update_end_position():
	if(_body != null && _end != null):
		var pos = _body.get_position()
		pos.x += beam_size_x*1-141
		pos.rotated(self.get_rotation())
		_end.set_position(pos)
