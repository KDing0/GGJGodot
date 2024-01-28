extends CanvasLayer

signal game_over

func _ready():
	Livecounter.lives=3

func _process(delta):
	if Livecounter.lives==2:
		$HBoxContainer/Sprite2D3.visible = false
	if Livecounter.lives==1:
		$HBoxContainer/Sprite2D2.visible = false
	if Livecounter.lives==0:
		$HBoxContainer/Sprite2D.visible = false
		game_over.emit()
		#get_tree().reload_current_scene()
