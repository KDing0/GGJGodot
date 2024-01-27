extends Node

@export var tex_enemy : Array[Texture2D]

@export

var test = 1.0
var d = 0.0

var enemyScene = preload("res://Enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	d += delta
	if d > 1.0:
		spawnEnemy(Enemy.EnemyTypes.ENEMY_TYPE1)
		d = 0.0


func spawnEnemy(enemyType):
	var enemy_instance = enemyScene.instantiate()
	enemy_instance.set_parameters(tex_enemy[0], test)
	test += 1.0
	get_node("../EnemyPaths/Path2D").add_child(enemy_instance)
	
