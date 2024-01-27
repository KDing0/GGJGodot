extends CharacterBody2D

var count = 0
func _input(event):
	if event.is_action_pressed("LMB"):
		print("triggered")
		Spawning.spawn({"position": Vector2(200,200), "rotation": 15}, "one", "first")
