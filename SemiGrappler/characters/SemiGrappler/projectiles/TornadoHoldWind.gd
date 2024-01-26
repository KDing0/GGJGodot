extends BaseProjectile

@onready var sprite1 = $AnimatedSprite2D
@onready var sprite2 = $AnimatedSprite2

func _init():
	flip = $Flip

const FPS = 60


@export  var free = true
@export  var one_shot = true
@export  var lifetime = 1.0
@export  var start_enabled = true

var emitting = true
var enabled = true
var tick = 0

var sounds_played = {
	
}

@onready var tick_timer = $Timer


func set_speed_scale(speed):
	for child in get_children():
		if child.get("speed_scale") != null:
			child.speed_scale = speed

func tick():
	set_enabled(true)
	tick += 1
	for child in get_children():
		if child is AnimatedSprite2D:
			if child.frames.get_frame_count(child.animation) > tick:
				child.frame = tick
	if current_tick <= 0:
		update_data()

	if hitlag_ticks > 0:
		hitlag_ticks -= 1
	else :
		normal_tick()
	update_collision_boxes()
	update_data()
	if tick > lifetime:
		disable()

func get_enabled():
	return enabled

func set_enabled(on):
	enabled = on
	

func endExistance():
	disable()

func disable():
	sprite.hide()
	sprite1.hide()
	sprite2.hide()
	disabled = true
	for hitbox in get_active_hitboxes():
		hitbox.deactivate()
	stop_particles()

