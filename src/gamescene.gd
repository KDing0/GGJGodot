extends Node2D

signal game_over
signal victory

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lives.game_over.connect(on_game_over)
	$Lives.victory.connect(on_victory)

func on_game_over():
	game_over.emit()
	
func on_victory():
	victory.emit()
