extends PathFollow2D

@export var SPEED = 5.0

func _process(delta):
	progress_ratio += SPEED / 1000.0

func _on_timer_timeout():
	# shoot()
	pass

func shoot():
	# for anzahl bullets
	# 	instantiate bullets
	# 	set movement vector
	pass

# if hit by a player bullet:
# 	queue_free()
