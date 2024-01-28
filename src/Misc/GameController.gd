extends Node

@export var tex_enemy : Array[Texture2D]
@onready var player = $"../player"
@onready var waves = Waves.new()
@onready var enemyPaths = self.get_node("../EnemyPaths")
@onready var textCollision = self.get_node("../TextCollisions")

var spawnTimer = Timer.new()
var betweenWavesTimer = Timer.new() 
var enemy_batch = []
var enemy_inBatch_counter = 0

var enemyScene = preload("res://Enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Spawning.reset(true)
	betweenWavesTimer.one_shot = true
	spawnTimer.one_shot = true
	betweenWavesTimer.timeout.connect(startWave)
	spawnTimer.timeout.connect(_on_spawnTimer_Timeout)
	self.add_child(betweenWavesTimer)
	self.add_child(spawnTimer)
	betweenWavesTimer.start(5.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startWave():
	if !waves.startWave():
		print("No wave left! Game ended!")
	else:
		prepare_new_batch(0.5)

func prepare_new_batch(time):
	enemy_batch = waves.next()
	if enemy_batch.size() <= 0:
		betweenWavesTimer.start(10.0)
	else:
		spawnTimer.start(time)

func spawnEnemy(enemyType, path: int, speed: float):
	var enemy_instance = enemyScene.instantiate()
	enemy_instance.set_parameters(tex_enemy[enemyType], speed)
	get_node("../EnemyPaths/EnemyPath_0" + str(path)).add_child(enemy_instance)
	setInstantiateBulletPattern(enemy_instance, enemyType)

func _on_spawnTimer_Timeout():
	spawnEnemy(enemy_batch[0], enemy_batch[1], enemy_batch[2])
	enemyPaths.signal_emitted = false
	
	if enemy_inBatch_counter == 0:
		if enemy_batch[5] >= 0:
			textCollision.setText(waves.get_text(enemy_batch[5]))
	
	enemy_inBatch_counter += 1
	if enemy_batch[3] <= enemy_inBatch_counter:
		enemy_inBatch_counter = 0

		if enemy_batch[7] == 0:
			if !textCollision.signal_emitted:
				await textCollision.textbox_gone
			prepare_new_batch(enemy_batch[4])
		else:
			if !enemyPaths.signal_emitted:
				await enemyPaths.every_enemy_dead
			betweenWavesTimer.start(10.0)
		return
	
	spawnTimer.start(enemy_batch[6])
	
func setInstantiateBulletPattern(enemy_instance, enemyType):
	enemy_instance.playerInstance = player
	
	if(enemyType == 0):
		enemy_instance.BulletSpawnOffset = Vector2(0,0)
		enemy_instance.BulletSpawnID = "Football"
		enemy_instance.BulletAnimationID = "first"
		#TopLeft, TopRight, DownLeft, DownRight
		enemy_instance.BulletRotation = [-2.2,1,-2.2,1,]
		enemy_instance.BulletStartDelay = 1
		enemy_instance.BulletShootDelay = 0
		enemy_instance.BulletCycleAmount = 1
		enemy_instance.BulletCycleCooldown = 0.4
		enemy_instance.ShootingWalkSpeed = 1.0
		
	if(enemyType == 1):
		enemy_instance.BulletSpawnOffset = Vector2(0,0)
		enemy_instance.BulletSpawnID = "Cake"
		enemy_instance.BulletAnimationID = "first"
		#TopLeft, TopRight, DownLeft, DownRight
		enemy_instance.BulletRotation = [1,-1,1,-1]
		
		enemy_instance.BulletStartDelay = 2
		enemy_instance.BulletShootDelay = 0.059
		enemy_instance.BulletCycleAmount = 8
		enemy_instance.BulletCycleCooldown = 4
		enemy_instance.BulletRotationShift = 0.1
		enemy_instance.ShootingWalkSpeed = 0.0
		
	if(enemyType == 2):
		enemy_instance.BulletSpawnOffset = Vector2(0,0)
		enemy_instance.BulletSpawnID = "Weight"
		enemy_instance.BulletAnimationID = "first"
		#TopLeft, TopRight, DownLeft, DownRight
		enemy_instance.BulletRotation = [-2.2,1,-2.2,1]
		
		enemy_instance.BulletStartDelay = 2
		enemy_instance.BulletShootDelay = 0.3
		enemy_instance.BulletCycleAmount = 3
		enemy_instance.BulletCycleCooldown = 4
		enemy_instance.BulletRotationShift = 0
		enemy_instance.ShootingWalkSpeed = 0.4
		
	if(enemyType == 3):
		enemy_instance.BulletSpawnOffset = Vector2(0,0)
		enemy_instance.BulletSpawnID = "Carrot"
		enemy_instance.BulletAnimationID = "first"
		#TopLeft, TopRight, DownLeft, DownRight
		enemy_instance.BulletRotation = [-2.2,1,-2.2,1]
		
		enemy_instance.BulletStartDelay = 2
		enemy_instance.BulletShootDelay = 0.1
		enemy_instance.BulletCycleAmount = 10
		enemy_instance.BulletCycleCooldown = 4
		enemy_instance.BulletRotationShift = 0
		enemy_instance.ShootingWalkSpeed = 0.2

	if(enemyType == 4):
		enemy_instance.BulletSpawnOffset = Vector2(0,0)
		enemy_instance.BulletSpawnID = "Wrench"
		enemy_instance.BulletAnimationID = "first"
		#TopLeft, TopRight, DownLeft, DownRight
		enemy_instance.BulletRotation = [-2.2,1,-2.2,1]
		
		enemy_instance.BulletStartDelay = 2
		enemy_instance.BulletShootDelay = 0
		enemy_instance.BulletCycleAmount = 1
		enemy_instance.BulletCycleCooldown = 4
		enemy_instance.BulletRotationShift = 0
		enemy_instance.ShootingWalkSpeed = 0
		enemy_instance.PreShotSlowTime = 0.4
