extends PathFollow2D
class_name Enemy


@export var SPEED = 5.0
@export var BulletSpawnID = "one"
@export var BulletAnimationID = "first"
@export var BulletRotation = 15
@export var BulletSpawnOffset = Vector2(0,0)

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

func _input(event):
	if event.is_action_pressed("PTest"):
		print("triggered")
		var pos = global_position + BulletSpawnOffset
		Spawning.spawn({"position": pos, "rotation": 15}, "one", "first")

func shoot():
	# for anzahl bullets
	# 	instantiate bullets
	# 	set movement vector
	pass

# if hit by a player bullet:
# 	queue_free()
