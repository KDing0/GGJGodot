extends PathFollow2D

@export var SPEED = 5.0
@export var BulletSpawnID = "one"
@export var BulletAnimationID = "first"
@export var BulletRotation = 15
@export var BulletSpawnOffset = Vector2(0,0)

func _process(delta):
	progress_ratio += SPEED / 1000.0

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
