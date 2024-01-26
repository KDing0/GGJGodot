extends DefaultFireball

@onready var hitbox = $Hitbox

func _tick():
	super._tick()
	if host.is_grounded():
		host.has_projectile_parry_window = false
		hitbox.hit_height = Hitbox.HitHeight.Low
	else :
		host.has_projectile_parry_window = true
		hitbox.hit_height = Hitbox.HitHeight.Mid

func _got_parried():
	host.disable()

func _on_hit_something(obj, _hitbox):
	if obj.is_in_group("Fighter"):
		host.disable()

	
func _enter_shared():
	if reset_momentum:
		host.reset_momentum()
	current_tick = - 1
	current_real_tick = - 1
	start_tick = host.current_tick
	if enter_sfx_player and not ReplayManager.resimulating:
		enter_sfx_player.play()
	emit_signal("state_started")
	if data and data.has("sprite_animation"):
		anim_name = data["sprite_animation"]
		sprite_animation = data["sprite_animation"]
	if data and data.has("flip"):
		host.set_facing(data["flip"])



