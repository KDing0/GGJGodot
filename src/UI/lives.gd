extends CanvasLayer

var MAX_LAUGHS = 5
signal game_over
signal victory
var empty_heart = preload("res://Assets/UI/heart_empty.png")

func _ready():
	Livecounter.lives=3
	LaughCounter.laughs=0
	LaughCounter.maxlaughs = Waves.waveMap.size()
	MAX_LAUGHS = float(LaughCounter.maxlaughs)
	$HBoxContainer/HBoxContainer2/ProgressBar.max_value = MAX_LAUGHS

func _process(delta):
	var progress = LaughCounter.laughs
	$HBoxContainer/HBoxContainer2/ProgressBar.value = progress
	if Livecounter.lives==2:
		$HBoxContainer/HBoxContainer/Sprite2D.texture = empty_heart
	if Livecounter.lives==1:
		$HBoxContainer/HBoxContainer/Sprite2D2.texture = empty_heart
	if Livecounter.lives==0:
		$HBoxContainer/HBoxContainer/Sprite2D3.texture = empty_heart
		game_over.emit()
		#get_tree().reload_current_scene()
		
	if progress == MAX_LAUGHS:
		victory.emit()
