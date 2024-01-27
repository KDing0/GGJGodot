extends CanvasLayer

signal restartGame
signal toMenu

func _on_btn_restart_game_pressed():
	restartGame.emit()

func _on_btn_to_menu_pressed():
	toMenu.emit()
