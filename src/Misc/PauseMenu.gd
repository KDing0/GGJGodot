extends CanvasLayer

signal resumeGame
signal toMenu
signal musicChanged(newVal)
signal sfxChanged(newVal)

func _on_btn_resume_game_pressed():
	resumeGame.emit()

func _on_btn_to_menu_pressed():
	toMenu.emit()
	
func _on_slider_music_value_changed(value):
	musicChanged.emit(value)
	
func _on_slider_sfx_value_changed(value):
	sfxChanged.emit(value)

func setMusicAndSFX(val_music: float, val_sfx: float):
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Slider_Music.value = val_music
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Slider_SFX.value = val_sfx
