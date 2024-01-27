extends Node
class_name Waves

# EnemyType, PathID, Speed, Amount of Enemies, Time to next batch
const wave_1 = [
	[Enemy.EnemyTypes.ENEMY_TYPE1, 1, 5.0, 10, 2],
	[Enemy.EnemyTypes.ENEMY_TYPE1, 2, 50.0, 10]
]

const waveMap = {0: wave_1}

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
