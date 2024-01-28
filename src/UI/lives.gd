extends CanvasLayer

signal game_over
var empty_heart = preload("res://Assets/UI/heart_empty.png")

func _ready():
	Livecounter.lives=3

func _process(delta):
	if Livecounter.lives==2:
		$HBoxContainer/Sprite2D.texture = empty_heart
	if Livecounter.lives==1:
		$HBoxContainer/Sprite2D2.texture = empty_heart
	if Livecounter.lives==0:
		$HBoxContainer/Sprite2D.texture = empty_heart
		game_over.emit()
		#get_tree().reload_current_scene()
