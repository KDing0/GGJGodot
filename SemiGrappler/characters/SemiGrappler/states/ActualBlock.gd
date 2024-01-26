extends ParryState
class_name ActualBlockState

var fixedRecovery = true


func _ready():
	initial_parry_type = parry_type




func is_usable():
	return super.is_usable() and host.current_state().state_name != "WhiffInstantCancel"

func _frame_10():
	if can_parry:
		if not parried and perfect:
			parry_active = false

func parry(perfect = true):
	perfect = perfect and can_parry
	if perfect:
		enable_interrupt()
	else :
		parry_type = ParryHeight.Both
	host.parried = true
	parried = true
	self.perfect = perfect

func can_parry_hitbox(hitbox):
	if not perfect:
		return true
	if hitbox == null:
		return false
	if not active:
		return false
	if not parry_active:
		return false
	match hitbox.hit_height:
		Hitbox.HitHeight.High:
			return parry_type == ParryHeight.High or parry_type == ParryHeight.Both
		Hitbox.HitHeight.Mid:
			return parry_type == ParryHeight.High or parry_type == ParryHeight.Both
		Hitbox.HitHeight.Low:
			return parry_type == ParryHeight.Low or parry_type == ParryHeight.Both
	return false

func _tick():
	anim_length = 20
	host.apply_fric()
	if air_type == AirType.Aerial:
		host.apply_grav()


	host.apply_forces()


func _frame_20():
	enable_interrupt()


func _exit():
	host.blocked_last_hit = false
