extends Node
class_name Waves

# EnemyType, PathID, Speed, Amount of Enemies, Time to next batch
# If there is no next batch, just leave the last element
const wave_1 = [
	[Enemy.EnemyTypes.ENEMY_TYPE1, 1, 70.0, 1, 2],
	[Enemy.EnemyTypes.ENEMY_TYPE2, 2, 90.0, 1, 2],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 3, 80.0, 1]
]
const wave_2 = [
	[Enemy.EnemyTypes.ENEMY_TYPE2, 2, 80.0, 1, 0.5],
	[Enemy.EnemyTypes.ENEMY_TYPE2, 1, 90.0, 1, 0.5],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 2, 60.0, 1, 0.5],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 1, 70.0, 1]
]

const waveMap = {0: wave_1, 1: wave_2}

var currentWave : int = -1
var currentBatch : int = -1

func startWave() -> bool:
	currentWave += 1
	currentBatch = -1
	print("INFO: Start wave: ", currentWave)
	return waveMap.has(currentWave)

func next() -> Array:
	currentBatch += 1
	if waveMap[currentWave].size() <= currentBatch:
		return []
	return waveMap[currentWave][currentBatch]
