extends Node2D

signal game_over

func _ready():
	Livecounter.lives=3

func _physics_process(delta):
	if Livecounter.lives==2:
		$Sprite2D3.hide()
	if Livecounter.lives==1:
		$Sprite2D2.hide()
	if Livecounter.lives==0:
		$Sprite2D.hide()
		game_over.emit()
		#get_tree().reload_current_scene()
