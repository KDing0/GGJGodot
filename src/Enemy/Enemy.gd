extends PathFollow2D
class_name Enemy

enum EnemyTypes {ENEMY_TYPE1, ENEMY_TYPE2}

var speed = 5.0

func set_parameters(p_texture: Texture2D = null, p_speed: float = 5.0) -> void:
	if p_texture:
		$Sprite2D.texture = p_texture
	speed = p_speed
	
	self.rotates = false
	self.loop = false

func _process(delta):
	progress_ratio += speed / 1000.0
	if progress_ratio >= 1.0:
		self.queue_free()

func _on_timer_timeout():
	# shoot()
	pass

func shoot():
	# for anzahl bullets
	# 	instantiate bullets
	# 	set movement vector
	pass

# if hit by a player bullet:
# 	queue_free()
