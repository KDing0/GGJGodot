extends Node

enum States {MAIN_MENU, PAUSE_MENU, INGAME, GAMEOVER}

const sceneStr_mainMenu = "res://Misc/MainMenu.tscn"
const sceneStr_pauseMenu = "res://Misc/PauseMenu.tscn"
const sceneStr_game = "res://gamescene.tscn"
const sceneStr_gameOver = "res://Misc/GameOver.tscn"

# -1 is no scene
var currentState = -1

var val_music = 1.0
var val_sfx = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	loadMainMenu()

func _input(event):
	if Input.is_action_just_pressed("pause_game"):
		if currentState == States.INGAME:
			loadPauseMenu()
		elif currentState == States.PAUSE_MENU:
			resume_game()

func freeAllChildren():
	for c in self.get_children():
		c.queue_free()

func loadMainMenu():
	if currentState == States.MAIN_MENU:
		return
	
	get_tree().paused = false
	Spawning.reset_bullets()
	freeAllChildren()

	var scene_mainMenu = preload(sceneStr_mainMenu)
	var instance_mainMenu = scene_mainMenu.instantiate()
	currentState = States.MAIN_MENU
	
	instance_mainMenu.setMusicAndSFX(val_music, val_sfx)
	instance_mainMenu.startGame.connect(startGame)
	instance_mainMenu.musicChanged.connect(music_changed)
	instance_mainMenu.sfxChanged.connect(sfx_changed)
	self.add_child(instance_mainMenu)

func loadPauseMenu():
	if currentState != States.INGAME:
		return
	
	get_tree().paused = true
	var scene_pauseMenu = preload(sceneStr_pauseMenu)
	var instance_pauseMenu = scene_pauseMenu.instantiate()
	
	instance_pauseMenu.setMusicAndSFX(val_music, val_sfx)
	instance_pauseMenu.resumeGame.connect(resume_game)
	instance_pauseMenu.toMenu.connect(loadMainMenu)
	instance_pauseMenu.musicChanged.connect(music_changed)
	instance_pauseMenu.sfxChanged.connect(sfx_changed)
	
	currentState = States.PAUSE_MENU
	self.add_child(instance_pauseMenu)

func loadGameOverMenu():
	if currentState != States.INGAME:
		return
	
	get_tree().paused = true
	var scene_gameOverMenu = preload(sceneStr_gameOver)
	var instance_gameOverMenu = scene_gameOverMenu.instantiate()
	
	#instance_gameOverMenu.restartGame.connect(restart_game)
	instance_gameOverMenu.toMenu.connect(loadMainMenu)
	
	currentState = States.GAMEOVER
	self.add_child(instance_gameOverMenu)


func startGame():
	if currentState != States.MAIN_MENU:
		return
	
	get_tree().paused = false
	# create game instance
	var scene_game = preload(sceneStr_game)
	var instance_game = scene_game.instantiate()
	instance_game.game_over.connect(loadGameOverMenu)
	
	# delete menu scene
	self.get_child(0).queue_free()
	currentState = States.INGAME
	
	self.add_child(instance_game)

# PAUSE MENU STUFF
func resume_game():
	if currentState != States.PAUSE_MENU:
		return
	
	get_tree().paused = false
	currentState = States.INGAME
	self.get_child(1).queue_free()

# SOUND STUFF
func music_changed(value):
	val_music = value
func sfx_changed(value):
	val_sfx = value

