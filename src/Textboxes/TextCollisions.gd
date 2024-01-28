extends Node2D

@export var cam: Camera2D
@export var textbox: CanvasLayer

func _ready():
	var textHitArea = textbox.add_area_on("Test")
	textHitArea.hit.connect(_on_text_hit)
	self.add_child(textHitArea)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = Vector2.ZERO + cam.position

func _on_text_hit(from, to):
	textbox.changeText(from, to)
