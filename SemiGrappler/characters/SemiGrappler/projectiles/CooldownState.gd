extends DefaultFireball

@onready var hitbox = $Hitbox

const ROTATE_AMOUNT = 22.5

func _on_hit_something(obj, _hitbox):
	if clash:
		if obj is BaseProjectile:
			obj.disable()
			if not obj.deletes_other_projectiles:
				return 
		num_hits -= 1
		if num_hits == 0:
			fizzle()
	
func _tick():
	super._tick()
	#host.sprite.rotation += deg2rad(ROTATE_AMOUNT) * host.get_facing_int()
