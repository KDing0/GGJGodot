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
	
func _ready():
	$Area2D.body_entered.connect(_on_Bullet_entered)

func _on_Bullet_entered(body):
	var collisionLayer = body.get_collision_layer()
	if collisionLayer == 16:
		# Bullet Hit Enemy
		body.queue_free()
		queue_free()
	if collisionLayer == 2:
		#player runs into Enemy
		Livecounter.lives = Livecounter.lives - 1

func _process(delta):
	progress_ratio += speed / 1000.0
	if progress_ratio >= 1.0:
		self.queue_free()

func _on_timer_timeout():
	# shoot()
	pass

func _input(event):
	if event.is_action_pressed("PTest"):
		
		var pos = global_position + BulletSpawnOffset
		Spawning.spawn({"position": pos, "rotation": BulletRotation}, BulletSpawnID, BulletAnimationID)

func shoot():
	# for anzahl bullets
	# 	instantiate bullets
	# 	set movement vector
	pass

# if hit by a player bullet:
# 	queue_free()
