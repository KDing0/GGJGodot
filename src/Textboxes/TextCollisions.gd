extends Node2D

@export var cam: Camera2D
@export var textbox: CanvasLayer

func _ready():
	var textHitArea = textbox.add_area_on("Bla")
	textHitArea.hit.connect(_on_text_hit)
	self.add_child(textHitArea)
	
	var tHA2 = textbox.add_area_on("Hello")
	tHA2.hit.connect(_on_text_hit)
	self.add_child(tHA2)
	
	var tHA3 = textbox.add_area_on("Test")
	tHA3.hit.connect(_on_text_hit)
	self.add_child(tHA3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = cam.get_screen_center_position()
	print(position)

func _on_text_hit(from, to):
	textbox.changeText(from, to)
