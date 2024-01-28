extends Node2D

@export var cam: Camera2D
@export var textbox: CanvasLayer
@export var timeout_time = 5

var timer = Timer.new()

signal textbox_gone

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	self.add_child(timer)

func _process(delta):
	self.position = cam.get_screen_center_position()

func _on_text_hit(from, to):
	textbox.changeText(from, to)
	if self.get_child_count() <= 2:
		textbox.closeTextBox()
		textbox_gone.emit()

func setText(text_array):
	textbox.setText(text_array[0])
	var textHitArea = textbox.add_area_on(text_array[1], text_array[2])
	textHitArea.hit.connect(_on_text_hit)
	self.add_child(textHitArea)
	timer.start(timeout_time)

func _on_timer_timeout():
	timer.stop()
	for c in self.get_children():
		if c is Timer:
			continue
		c.queue_free()
	textbox.closeTextBox()
	textbox.setAngry()
	textbox_gone.emit()
