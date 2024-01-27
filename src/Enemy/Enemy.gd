extends PathFollow2D
class_name Enemy


@export var SPEED = 5.0
@export var BulletSpawnID = "one"
@export var BulletAnimationID = "first"
@export var BulletRotation = 15.0
@export var BulletSpawnOffset = Vector2(0,0)

@export var BulletStartDelay = 0.0
@export var BulletShootDelay = 0.0
@export var BulletCycleAmount = 0
@export var BulletCycleCooldown = 0.0
@export var BulletRotationShift = 0.0

var timer = 0
var firstShot = true
var nextShotCooldown = 0 
var shotCycle = 0
var rotationShift = 0


enum EnemyTypes {ENEMY_TYPE1, ENEMY_TYPE2}

var speed = 5.0
var enemy_type

func set_parameters(p_texture: Texture2D = null, p_speed: float = 5.0, p_type := EnemyTypes.ENEMY_TYPE1) -> void:
	if p_texture:
		$Sprite2D.texture = p_texture
	speed = p_speed
	enemy_type = p_type

func _ready():
	$AnimationPlayer.play("move")
	self.rotates = false
	self.loop = false
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
	progress += speed
	if progress_ratio >= 1.0:
		self.queue_free()
	shootCooldownCounting(delta)
	
	
func _on_timer_timeout(delta):
	# shoot()
	pass

func _input(event):
	if event.is_action_pressed("PTest"):
		shoot()
		
func shoot():
	var pos = global_position + BulletSpawnOffset
	rotationShift += BulletRotationShift
	Spawning.spawn({"position": pos, "rotation": BulletRotation + rotationShift}, BulletSpawnID, BulletAnimationID)


func shootCooldownCounting(delta):
	timer = timer + delta
	if(firstShot == true and timer >= BulletStartDelay):
		firstShot = false
		timer = 0
		shotCycle = shotCycle + 1
		if(BulletCycleAmount >= 1):
			nextShotCooldown = BulletShootDelay
			if(shotCycle >= BulletCycleAmount):
				nextShotCooldown += BulletCycleCooldown
		shoot()
	
	if(BulletCycleCooldown > 0 and BulletCycleAmount >= 1 and firstShot == false and timer >= nextShotCooldown):
		timer = 0
		shotCycle = shotCycle + 1
		if(BulletCycleAmount >= 1):
			nextShotCooldown = BulletShootDelay
			if(shotCycle >= BulletCycleAmount):
				shotCycle = 0
				nextShotCooldown += BulletCycleCooldown
		shoot()
# if hit by a player bullet:
# 	queue_free()
