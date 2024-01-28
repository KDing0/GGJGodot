extends Node
class_name Waves

# EnemyType, PathID, Speed, Amount of Enemies, Time to next batch, Portrait ID,  Time between unit spawns, LastBatch
const wave_1 = [
	[Enemy.EnemyTypes.ENEMY_TYPE1, 4, 70.0, 5, 0,  	0, 	0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 3, 90.0, 10, 1, 	-1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE2, 4, 90.0, 4, 2,  	-1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE3, 3, 80.0, 7, 5, 	1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 1, 70.0, 5, 0, 	-1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE2, 3, 70.0, 10, 2, 	-1, 0.5, 1],
]
const wave_2 = [
	[Enemy.EnemyTypes.ENEMY_TYPE4, 2, 80.0, 3, 1, 2, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE5, 1, 90.0, 10, 2, -1, 0.8, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 2, 60.0, 10, 0.2, -1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 4, 80.0, 15, 0, 3, 0.3, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE3, 2, 60.0, 10, 0, -1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE3, 3, 60.0, 10, 0, -1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE2, 1, 70.0, 10, 1, -1, 0.5, 1]
]

const wave_3= [
	[Enemy.EnemyTypes.ENEMY_TYPE1, 1, 110.0, 10, 1, 4, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE5, 2, 110.0, 10, 0.3, -1, 0.8, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE4, 3, 110.0, 15, 0.2, -1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE2, 4, 110.0, 15, 0, 5, 0.3, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE3, 3, 110.0, 20, 0, -1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE3, 2, 110.0, 25, 0, -1, 0.5, 0],
	[Enemy.EnemyTypes.ENEMY_TYPE2, 1, 110.0, 5, 1, -1, 0.5, 1]
]

const waveMap = {0: wave_1, 1: wave_2, 2: wave_3}

# Text, from_word, to_word
const texts = [
	["Can't you make me cry", "cry", "laugh"],
	["Tell me a sad story", "sad", "funny"],
	["You and my family get along terribly :(", "terribly :(", "great :)"],
	["You are really bad at this", "bad", "good"],
	["We should hang out less", "less", "more"],
	["You are so lame", "lame", "funny"],
]

var currentWave : int = -1
var currentBatch : int = -1

func startWave() -> bool:
	currentWave += 1
	currentBatch = -1
	print("INFO: Start wave: ", currentWave)
	if (currentWave != 0):
		LaughCounter.laughs = LaughCounter.laughs + 1
	return waveMap.has(currentWave)

func next() -> Array:
	currentBatch += 1
	if waveMap[currentWave].size() <= currentBatch:
		return []
	return waveMap[currentWave][currentBatch]

func get_text(id):
	return texts[id]a
