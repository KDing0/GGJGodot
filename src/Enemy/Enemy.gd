extends PathFollow2D
class_name Enemy

var playerInstance
var oldPos = global_position
var savedAngle = 0

@export var SPEED = 5.0
@export var BulletSpawnID = "one"
@export var BulletAnimationID = "first"
#TopLeft, TopRight, DownLeft, DownRight
@export var BulletRotation = [0,0,0,0]
@export var BulletSpawnOffset = Vector2(0,0)

@export var BulletStartDelay = 0.0
@export var BulletShootDelay = 0.0
@export var BulletCycleAmount = 0
@export var BulletCycleCooldown = 0.0
@export var BulletRotationShift = 0.0

@export var ShootingWalkSpeed = 1.0
@export var PreShotSlowTime = 0.0

var timer = 0
var firstShot = true
var nextShotCooldown = 0 
var shotCycle = 0
var rotationShift = 0

enum EnemyTypes {ENEMY_TYPE1, ENEMY_TYPE2, ENEMY_TYPE3, ENEMY_TYPE4, ENEMY_TYPE5}

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
	var g = body.get_groups()
	if(g.size() > 0):
		if(g[0] == "Tile"):
			return
	var collisionLayer = body.get_collision_layer()
	if collisionLayer == 16:
		# Bullet Hit Enemy
		body.queue_free()
		queue_free()
	if collisionLayer == 2:
		#player runs into Enemy
		Livecounter.lives = Livecounter.lives - 1
		

func _process(delta):
	var timeTillShot = nextShotCooldown - timer
	if(shotCycle > 0 || (timeTillShot <= PreShotSlowTime and PreShotSlowTime > 0)):
		progress += speed*delta*ShootingWalkSpeed
	else: progress += speed*delta
	if progress_ratio >= 1.0:
		self.queue_free()
	shootCooldownCounting(delta)
	turn_around_check()


func turn_around_check():
	var isLeft = oldPos[0] > global_position[0]
	$Sprite2D.flip_h = isLeft
	oldPos = global_position
	
func _on_timer_timeout(delta):
	# shoot()
	pass

func _input(event):
	if event.is_action_pressed("PTest"):
		shoot()
		
func shoot():
	var pos = global_position + BulletSpawnOffset
	rotationShift += BulletRotationShift
	var angle = BulletRotation[shootAngle() ] + rotationShift
	Spawning.spawn({"position": pos, "rotation": angle }, BulletSpawnID, BulletAnimationID)

func shootAngle()->int:
	var angle = 0
	var playerX = playerInstance.global_position[0]
	var playerY = playerInstance.global_position[1]
	if(global_position[0] <= playerX):
		angle += 1
	if(global_position[1] <= playerY):
		angle += 2
	return angle
	
func shootCooldownCounting(delta):
	timer += delta
	if(firstShot == true):
		nextShotCooldown = BulletStartDelay
		firstShot = false
	
	if(BulletCycleCooldown > 0 and BulletCycleAmount >= 1 and firstShot == false and timer >= nextShotCooldown):
		timer = 0
		if(shotCycle == 0):
			savedAngle = shootAngle()
		shoot()
		shotCycle = shotCycle + 1
		if(BulletCycleAmount >= 1):
			nextShotCooldown = BulletShootDelay
			if(shotCycle >= BulletCycleAmount):
				shotCycle = 0
				nextShotCooldown += BulletCycleCooldown
# if hit by a player bullet:
# 	queue_free()
