extends Node2D

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lives.game_over.connect(on_game_over)

func on_game_over():
	game_over.emit()
