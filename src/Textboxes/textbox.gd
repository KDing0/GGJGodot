extends CanvasLayer

@onready var anims: AnimationPlayer = $AnimationPlayer

var textbox_open = false

func open_textbox():
	if !textbox_open:
		anims.play("open_textbox")
		textbox_open = true

func close_textbox():
	if textbox_open:
		anims.play("close_textbox")
		textbox_open = false
