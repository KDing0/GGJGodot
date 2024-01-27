extends Node

@export var tex_enemy : Array[Texture2D]

@onready var waves = Waves.new()
@onready var enemyPaths = self.get_node("../EnemyPaths")

var spawnTimer = Timer.new()
var betweenWavesTimer = Timer.new() 
var enemy_batch = []
var enemy_inBatch_counter = 0

var enemyScene = preload("res://Enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
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
	enemy_instance.set_parameters(tex_enemy[0], speed)
	get_node("../EnemyPaths/EnemyPath_0" + str(path)).add_child(enemy_instance)
	setInstantiateBulletPattern(enemy_instance, enemyType)

func _on_spawnTimer_Timeout():
	spawnEnemy(enemy_batch[0], enemy_batch[1], enemy_batch[2])
	enemyPaths.signal_emitted = false
	
	enemy_inBatch_counter += 1
	if enemy_batch[3] <= enemy_inBatch_counter:
		enemy_inBatch_counter = 0
		if enemy_batch.size() >= 5:
			prepare_new_batch(enemy_batch[4])
		else:
			if !enemyPaths.signal_emitted:
				await enemyPaths.every_enemy_dead
			betweenWavesTimer.start(10.0)
		return
	
	spawnTimer.start(0.5)
	
func setInstantiateBulletPattern(enemy_instance, enemyType):
	enemy_instance.BulletSpawnOffset = Vector2(0,0)
	enemy_instance.BulletSpawnID = "one"
	enemy_instance.BulletAnimationID = "first"
	enemy_instance.BulletRotation = 0
	
	enemy_instance.BulletStartDelay = 1
	enemy_instance.BulletShootDelay = 0.12
	enemy_instance.BulletCycleAmount = 5
	enemy_instance.BulletCycleCooldown = 5
