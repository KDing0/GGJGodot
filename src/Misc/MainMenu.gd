extends Control

signal startGame
signal musicChanged(newVal)
signal sfxChanged(newVal)

func _on_start_game_btn_pressed():
	startGame.emit()
	
func _on_slider_music_value_changed(value):
	musicChanged.emit(value)
	
func _on_slider_sfx_value_changed(value):
	sfxChanged.emit(value)

func setMusicAndSFX(val_music: float, val_sfx: float):
	$MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/Slider_Music.value = val_music
	$MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/Slider_SFX.value = val_sfx
